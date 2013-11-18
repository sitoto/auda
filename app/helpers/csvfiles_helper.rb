module CsvfilesHelper
  def render_category_csvfile_select_tag(property, csvfile)
    return if property.blank?
    return if csvfile.blank?
    parameters = csvfile.temproducts.first.parameters
    
    collection_select :pairparameters, property.id, parameters, :name, :name, {:prompt => t('pairs.select')}, :style => "width:145px;"
  end

  def render_csvfile_status_tag(status)
    return t('csvfiles.pipei') if status == 1
    return t('csvfiles.unpipei') if status == 0

  end
 
end
