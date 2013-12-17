require 'csv'
class CsvfilesController < ApplicationController
  before_action :set_csvfile, only: [:show, :edit, :update, :destroy, :download]
  load_and_authorize_resource except: [:create]
  layout "main"

  # GET /csvfiles
  # GET /csvfiles.json
  def index
    @category = Category.find(params[:category_id])
    @csvfiles = @category.csvfiles.desc(:id) 
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

  def edit
  end

  def create
    @category = Category.find(params[:category_id])
    @csvfile = Csvfile.new(csvfile_params)
    @csvfile.category = @category
    @csvfile.user = current_user
    file_name = params[:csvfile][:source].original_filename

    file_data = params[:csvfile][:source].read
    csv_rows = CSV.parse(file_data)

    unstandtitle = [] 
    csv_rows.each_with_index do  |row, i|
      if i == 0
        unstandtitle = row 
        next
      else
        product =  Temproduct.new
        unstandtitle.each_with_index do |pname, j|
          parameter = Parameter.new(name: pname, value: row[j])
          product.parameters << parameter
        end
        product.csvfile = @csvfile
        product.save

      end 
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
#  rescue
#    flash[:danger] = t('csvfiles.error_upload') 
#    redirect_to new_category_csvfile_path(@category)  
  end

  def update
    respond_to do |format|
      if @csvfile.update(csvfile_params)
        format.html { redirect_to @csvfile, notice: 'Csvfile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @csvfile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /csvfiles/1
  # DELETE /csvfiles/1.json
  def destroy
    @csvfile.destroy
    respond_to do |format|
      format.html { redirect_to category_csvfiles_path(@category) }
    end
  end

  private
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
