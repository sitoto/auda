module ProductsHelper
  def render_product_category_select_tag(product)
    return if product.blank?
    collection_select :product, :category_id, Category.all, :id, :name, {:prompt => t('categories.select')}, :style => "width:145px;"
  end
end
