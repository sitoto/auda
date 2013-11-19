#encoding: UTF-8
class Node
  include Mongoid::Document
  field :name, type: String
  field :position, type: Integer, default: 10

  has_many :child_nodes, :class_name => 'Node', :inverse_of => :parent_node
  belongs_to :parent_node, :class_name => 'Node', :inverse_of => :child_nodes

  has_many :categories

  def get_tree(tree)
    if self.root?
      tree << ["#{self.name}", "#{self.id}"]
    else
      level = self.depth
      bloc = "　" * level
      tree << [bloc + "|--#{self.name}", "#{self.id}"]
    end
    if self.child_nodes?
      self.child_nodes.each do |chi|
        chi.get_tree(tree)
      end
    end
  end
  def self.roots
    Node.where(parent_node: nil).asc(:position)
  end

  def root?
    self.parent_node.blank? ? true : false
  end

  def depth
    i = 0
    @k = self
    while @k.parent_node
      i += 1
      @k = @k.parent_node
    end
    i
  end

end
