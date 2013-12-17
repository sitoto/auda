module PairsHelper
  def render_get_property_name_tag(id)
    property = Property.find(id)
    return '' if property.blank?
    return "#{property.name}(#{property.alias})"
  end
end
