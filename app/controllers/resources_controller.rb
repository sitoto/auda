class ResourcesController < ApplicationController
  before_action :set_resource, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource except: [:create]

  def index
    para_category_id = params[:category_id]
    @category =  Category.find(para_category_id)
    @resources = @category.resources.asc(:id).page params[:page]

    @page_title = "#{@category.name}: #{t('resources.list')}"
    respond_to do |format|
      format.html # index.html.erb    
      format.js{ render :layout => false}
    end
  end

  def all 
    @resources = Resource.all.asc(:id).page params[:page]
    @page_title = t('resources.list')
  end
  def show
    para_category_id = params[:category_id]
    @page_title = @resource.name
    if para_category_id
      @category = Category.find(para_category_id)
    end
  end

  def new
    para_category_id = params[:category_id]
    @resource = Resource.new

    if para_category_id
      @category = Category.find(para_category_id)
      @page_title = "#{ t('categories.name')}: #{@category.name} - #{ t('resources.new')}" 
    end

  end

  # GET /resources/1/edit
  def edit
  end

  # POST /resources
  # POST /resources.json
  def create
    @category = Category.find(params[:category_id])

    #    if params[:resource][:photo].blank?
    #      flash[:danger] = t('resources.select_upload')
    #      redirect_to new_category_resource_path(@category, @resource)  
    #      return
    #    end

    begin
      file = params[:qqfile].is_a?(ActionDispatch::Http::UploadedFile) ? params[:qqfile] : params[:file]
      @resource  = Resource.new
      @resource.photo = file
      @resource.category = @category
      @resource.name =  params[:qqfile].to_s.strip
      respond_to do |format|
        if @resource.save
          render json: { success: true, src: @resource.to_json }
        else
          render json: @resource.errors.to_json 
        end
      end
    rescue StandardError  
      flash[:danger] = t('resources.error_upload') + "Error: " + $!.to_s
      redirect_to category_resources_path(@category)
    end

  end

  def update
    respond_to do |format|
      if @resource.update(resource_params)
        format.html { redirect_to @resource, notice: 'Resource was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resources/1
  # DELETE /resources/1.json
  def destroy
    @resource.destroy

    para_category_id = params[:category_id]
    if para_category_id
      @category = Category.find(para_category_id)
      redirect_to category_resources_url(@category)
    else
      redirect_to all_resources_url
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_resource
    @resource = Resource.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def resource_params
    params.require(:resource).permit(:photo, :note, :qqfile)
  end
end
