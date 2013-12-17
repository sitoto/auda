class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :set_category_id, only: [:getproperties]
  load_and_authorize_resource except: [:create]
  layout "main"
  

  def index
    @categories = Category.all.asc(:node_id).page params[:page]
    @page_title = t('categories.list')

  end

  def show
    @properties = @category.properties
    @property = Property.new
  end

  def branch_ids
    @node.child_nodes.map(&:id).uniq <<  @node.id
  end

  def node
   @node = Node.find(params[:node_id])
   #@categories = @node.categories.page params[:page]
   @categories = Category.in(node_id: branch_ids).page params[:page]
   @page_title = @node.name
   render :index

  end

  def new
    @category = Category.new
  end

  def edit
  end

  def getproperties
    @properties = @category.properties
    respond_to do |format|
      format.html { render :layout => false }
    end
  end

  def create
    @category = Category.new(category_params)
    @category.user = current_user

    if @category.save
      redirect_to @category, notice: t('categories.created')
    else
      render action: 'new'
    end
  end

  def update
    @category.last_edit_user = current_user

    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, success: t('categories.updated') }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_path  , notice: t('destroyed')}
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end
  def set_category_id
    @category = Category.find(params[:id])
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def category_params
    params.require(:category).permit(:name, :alias, :note, :node_id)
  end
  def property_params
    params.require(:property).permit(:code, :name, :value, :position)
  end

end
