require 'roo'

class CsvfilesController < ApplicationController
  before_action :set_csvfile, only: [:show, :edit, :update, :destroy, :download]
  load_and_authorize_resource except: [:create]
  layout "main"

  def index
    @category = Category.find(params[:category_id])
    @csvfiles = @category.csvfiles.desc(:id).page params[:page]
    @page_title = t('csvfiles.list')

  end

  def download
    content = @csvfile.source.read
    if stale?(etag: content, last_modified: @csvfile.updated_at.utc, public: true)
      send_data content, filename: @csvfile.name,  disposition: "inline"
      expires_in 0, public: true
    end
  end

  def show
    @temproducts = @csvfile.temproducts.limit(100)
    @page_title = @csvfile.name
  end

  def new
    @category = Category.find(params[:category_id])
    @csvfile = Csvfile.new
  end

  def create
    @category = Category.find(params[:category_id])
    @csvfile = Csvfile.new()#.init(csvfile_params)
    @csvfile.category = @category
    @csvfile.user = current_user

    file_name = params[:csvfile][:source].original_filename
    file_path = params[:csvfile][:source].path
    #file_data = params[:csvfile][:source].read
    #csv_rows = CSV.parse(file_data)

    spreadsheet = open_spreadsheet(file_name, file_path)
    header = spreadsheet.row(1)

    (2..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      product =  Temproduct.new
      row.each do |pname, value|
        parameter = Parameter.new(name: pname, value: value)
        product.parameters << parameter
      end
      product.csvfile = @csvfile
      product.save
    end
    params[:csvfile][:name] = file_name
    @csvfile.update(csvfile_params)

    respond_to do |format|
      if @csvfile.save
        format.html { redirect_to [@category, @csvfile], notice: t('csvfiles.created') }
      else
        format.html { render action: 'new' }
      end
    end
  rescue StandardError  
    flash[:danger] = t('csvfiles.error_upload') + "Error: " + $!.to_s
    redirect_to new_category_csvfile_path(@category)  
  end

  def destroy
    @csvfile.destroy
    respond_to do |format|
      format.html { redirect_to category_csvfiles_path(@category) }
    end
  end

  private
  def open_spreadsheet(file_name, file_path)
    case File.extname(file_name)
    when ".csv" then Roo::CSV.new(file_path,csv_options: {col_sep: ","})#, encoding: Encoding::ISO_8859_1})
    when ".xls" then Roo::Excel.new(file_path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file_path, nil, :ignore)
    else raise "Unknown file type: #{file_name}"
    end
  end


  # Use callbacks to share common setup or constraints between actions.
  def set_csvfile
    @category = Category.find(params[:category_id])
    @csvfile = Csvfile.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def csvfile_params
    params.require(:csvfile).permit(:name, :creater, :size, :source)
  end
end
