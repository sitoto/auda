module ProductsHelper
  def render_product_category_select_tag(product)
    return if product.blank?
    collection_select :product, :category_id, Category.all, :id, :name, {:prompt => t('categories.select')}, :style => "width:145px;"
  end
  def render_product_parameter_value_tag(product, id) 
    return '' if product.blank?
    return '' if product.parameters.blank?
    return product.parameters.where(code: id).first.value
  end
end
