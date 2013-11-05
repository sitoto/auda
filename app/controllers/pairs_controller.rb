class PairsController < ApplicationController
  before_action :set_pair, only: [:show, :edit, :update, :destroy]

  # GET /pairs
  # GET /pairs.json
  def index
    @pairs = Pair.all
  end

  # GET /pairs/1
  # GET /pairs/1.json
  def show
  end

  # GET /pairs/new
  def new
    @category = Category.find(params[:category_id])
    @csvfile = Csvfile.find(params[:csvfile_id])
    @pair = Pair.new
  end

  # GET /pairs/1/edit
  def edit
  end

  # POST /pairs
  # POST /pairs.json
  def create
    @category = Category.find(params[:category_id])
    @csvfile = Csvfile.find(params[:csvfile_id])

    items = params[:pairparameters]
    return if items.blank?
    @csvfile.temproducts.each do |tp|
      product = @category.products.new
      pars = []

      items.each do |proid, parname|
        property = @category.properties.find(proid) 
        name = property.name 
        parameter = Parameter.new()     

        tp.parameters.each do |item|
          if  parname == item.name
            value = item.value
            parameter.name = name
            parameter.value = value     
            parameter.code = property.id
            break
          end
        end
        pars << parameter unless parameter.blank?
      end
      if pars.length > 0
        product.parameters = pars
        product.save
      end
      
    end
    @csvfile.update_attribute(:status, 1)
    @csvfile.save
   # @pair = Pair.new(pair_params)

    respond_to do |format|
      format.html { redirect_to category_products_path(@category), notice: t('csvfiles.created') }
    end
  end

  # PATCH/PUT /pairs/1
  # PATCH/PUT /pairs/1.json
  def update
    respond_to do |format|
      if @pair.update(pair_params)
        format.html { redirect_to @pair, notice: 'Pair was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @pair.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pairs/1
  # DELETE /pairs/1.json
  def destroy
    @pair.destroy
    respond_to do |format|
      format.html { redirect_to pairs_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_pair
    @category = Category.find(params[:category_id])
    @csvfile = Csvfile.find(params[:csvfile_id])
    @pair = Pair.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def pair_params
    #params.require(:pair).permit(:category_id, :csvfile_id, :hash_paris, :status)
    params.require(:pairparameters).permit(:category_id, :csvfile_id, :hash_paris, :status)

  end
end
