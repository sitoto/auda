class ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :update, :show, :agree]
  load_and_authorize_resource except: [:create]

  def index
    @category = Category.find(params[:category_id])
    @products = @category.products.page params[:page]
  end

  def draft 
    @category = Category.find(params[:category_id])
    @products = @category.products.draft.page params[:page]
    render :index
  end


  def show
  end

  def agree
    @product.status = 2 
    @product.save

    respond_to do |format|
      format.js {render layout: false}
    end

  end

  def new
    @product = Product.new
    @category = Category.find(params[:category_id])
    @category.properties.build
  end

  def edit
    @category.properties.build

  end

  def create
    @category = Category.find(params[:category_id])
    @product = @category.products.new()

    update_parameters

    respond_to do |format|
      if @product.save
        format.html { redirect_to [@category, @product], notice: t('products.created') }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    if current_user.data_manager? || @product.status == 0
      update_parameters
    end

    if @product.update(product_params)
      redirect_to [@category, @product], notice: t('updated') 
    else
      redirect_to [@category, @product], notice: t('error') 
      #    render action: 'edit' 
    end
  end


  def destroy
    @category = Category.find(params[:category_id])
    @product = Product.find(params[:id])
    if @product.status == 2
      redirect_to  category_products_url(@category), notice: t('destroyed_failed') 
    else
      @product.destroy
      redirect_to category_products_url(@category), notice: t('destroyed')
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
    @category = Category.find(params[:category_id])
  end

  def update_parameters
    pars = []
    items =  params[:product]
    return if items.blank?
    items.each do |code, value|
      puts value
      property = @category.properties.find(code) 
      name = property.name 
      parameter = Parameter.new(name:name, value: value)     
      parameter.code = property.id
      #        parameter.property = property 
      pars << parameter
    end
    if pars.length > 0
      @product.parameters = pars
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    params.require(:product).permit(:status, :user_name, :ip)
  end
  def product_params_parameter
    params.require(:product).permit!
  end
end
