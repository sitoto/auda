class PairsController < ApplicationController
  #before_action :set_pair, only: [:show]
  load_and_authorize_resource except: [:create]

  # GET /pairs
  # GET /pairs.json
  def index
    @pairs = Pair.all
  end

  # GET /pairs/1
  # GET /pairs/1.json
  def show
    @pair = Pair.find(params[:id])
  end

  # GET /pairs/new
  def new
    @category = Category.find(params[:category_id])
    @csvfile = Csvfile.find(params[:csvfile_id])
    @pair = Pair.new
  end


  # POST /pairs
  # POST /pairs.json
  def create
    @category = Category.find(params[:category_id])
    @csvfile = Csvfile.find(params[:csvfile_id])
    
    items = params[:pairparameters]
    return if items.blank?
    @pair = Pair.new()
    @pair.category = @category
    @pair.csvfile = @csvfile
    @pair.user = current_user
    @pair.hash_pairs = items

    @pair.save
   
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
        product.pair = @pair 
        product.save
      end
      
    end
    @csvfile.update_attribute(:status, 1)
    @csvfile.save
   
    respond_to do |format|
      format.html { redirect_to category_products_path(@category), notice: t('csvfiles.created') }
    end
  end

  # DELETE /pairs/1
  # DELETE /pairs/1.json
  def destroy
    @pair = Pair.find(params[:id])
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
    #params.require(:pairparameters).permit(:category_id, :csvfile_id, :hash_paris, :status)

  end
end
