module ProductsHelper
  def render_product_category_select_tag(product)
    return if product.blank?
    collection_select :product, :category_id, Category.all, :id, :name, {:prompt => t('categories.select')}, :style => "width:145px;"
  end
  def render_product_parameter_value_tag(product, id) 
    return '' if product.blank?
    return '' if product.parameters.blank?
    return '' if product.parameters.where(code: id).blank?
    return product.parameters.where(code: id).first.value
  end
  def render_status_tag(status)
    return '' if product.blank?
    case status
    when 0
        return t('draft')
    when 1
        return t('doing')
    when 2 
        return t('done')
    else
        return t('invalid')
    end

  end
  def render_product_status_tag(product)
    return '' if product.blank?
    case product.status
    when 0
       return "<span class='glyphicon glyphicon-edit'>#{t('draft')}</span>"
    when 1
       return "<span class='glyphicon glyphicon-check'>#{t('doing')}</span>"
    when 2 
       return "<span class='glyphicon glyphicon-ok'>#{t('done')}</span>"
    else
        return t('invalid')
    end

  end
end
