module NodesHelper
  def node_tree
    tree = []
    Node.roots.each do |node|
      node.get_tree(tree)
    end
    return tree
  end
 
  def render_parent_node_collection_tag
    collection_select :node, :parent_node_id, Node.where(parent_node: nil), :id, :name, {:prompt => t('nodes.select')}, :style => "width:145px;"
 
  end
end