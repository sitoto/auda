require 'csv'
class CsvfilesController < ApplicationController
  before_action :set_csvfile, only: [:show, :edit, :update, :destroy]

  # GET /csvfiles
  # GET /csvfiles.json
  def index
    @csvfiles = Csvfile.all
  end

  # GET /csvfiles/1
  # GET /csvfiles/1.json
  def show
  end

  # GET /csvfiles/new
  def new
    @csvfile = Csvfile.new
  end

  # GET /csvfiles/1/edit
  def edit
  end

  # POST /csvfiles
  # POST /csvfiles.json
  def create
    @csvfile = Csvfile.new(csvfile_params)

    file_data = params[:csvfile][:name].read
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


    respond_to do |format|
      if @csvfile.save
        format.html { redirect_to @csvfile, notice: 'Csvfile was successfully created.' }
        format.json { render action: 'show', status: :created, location: @csvfile }
      else
        format.html { render action: 'new' }
        format.json { render json: @csvfile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /csvfiles/1
  # PATCH/PUT /csvfiles/1.json
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
      format.html { redirect_to csvfiles_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_csvfile
    @csvfile = Csvfile.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def csvfile_params
    params.require(:csvfile).permit(:name, :creater, :size)
  end
end
