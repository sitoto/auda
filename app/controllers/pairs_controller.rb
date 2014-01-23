class PairsController < ApplicationController
  #before_action :set_pair, only: [:show]
  load_and_authorize_resource except: [:create]

  def index
    @pairs = Pair.all.desc(:id).page params[:page]
    @page_title = t('pairs.list')
  end

  def doing 
    @pair = Pair.find(params[:id])
    @pair.products.each do |product|
      product.update_attribute(:status, 1)
    end
    @products = @pair.products
    render :show
  end


  def agree
    @pair = Pair.find(params[:id])
    @pair.products.each do |product|
      product.update_attribute(:status, 2)
    end
    @products = nil
    render :show
  end

  def show
    @pair = Pair.find(params[:id])
    @products = @pair.products.where(:status.lt => 2 )
  end

  def new
    @category = Category.find(params[:category_id])
    @csvfile = Csvfile.find(params[:csvfile_id])
    @pair = Pair.new
    if @category.properties.length == 0
      flash[:danger] = @category.name + t('error_no_property')
      redirect_to category_csvfiles_path(@category)
    end
  end


  def create
    @category = Category.find(params[:category_id])
    @csvfile = Csvfile.find(params[:csvfile_id])

    items = params[:pairparameters]
    if items.blank?
      redirect_to [@category, @csvfile], notice: t("blank") 
      return
    end

    if @csvfile.status != 0
      redirect_to [@category, @csvfile], notice: t('csvfiles.imported')  
      return
    end

    # return if some required field if null
    items.each do |name, value|
      property = @category.properties.find(name) 

      if property.required && value.blank?
        flash[:danger] =  t("pipei_blank") 
        redirect_to new_category_csvfile_pair_path(@category, @csvfile)
        return
      end

    end
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
        alias_arr = property.alias.split(",")
        alias_arr <<  parname  unless (parname.blank? || parname.eql?(property.name))

        alias_arr.uniq!
        property.alias = alias_arr.join(',')
        property.save
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
        product.user = current_user
        product.save
      end

    end
    @csvfile.update_attribute(:status, 1)
    @csvfile.save

    respond_to do |format|
      format.html { redirect_to @pair, notice: t('csvfiles.imported') }
    end
  end

  def destroy
    @pair = Pair.find(params[:id])
    @pair.update(note: "数据被'#{current_user.email}'删除,#{Time.now}")
    @pair.update(status: 1)
    @pair.products.draft.destroy
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
