module NodesHelper
  def render_parent_node_collection_tag
    collection_select :parent_node, :id, Node.where(parent_node: nil), :id, :name, {:prompt => t('nodes.select')}, :style => "width:145px;"
 
  end
end
