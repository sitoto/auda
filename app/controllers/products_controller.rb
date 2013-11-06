class ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :update, :show]

  # GET /products
  # GET /products.json
  def index
    @category = Category.find(params[:category_id])
    @products = @category.products.page params[:page]
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
    @category = Category.find(params[:category_id])
    
  end

  # GET /products/1/edit
  def edit
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
    update_parameters
    respond_to do |format|
      if @product.save    #@product.update(product_params)
        format.html { redirect_to [@category, @product], notice: t('updated') }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @category = Category.find(params[:category_id])
    @product = Product.find(params[:id])
    @product.destroy
    respond_to do |format|
      format.html { redirect_to category_products_url(@category) }
      format.json { head :no_content }
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
      items = params[:product]
      return if items.blank?
      items.each do |code, value|
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
end
