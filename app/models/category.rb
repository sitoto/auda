class Category
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::CounterCache

  field :name, type: String
  field :alias, type: String
  field :note, type: String
  field :lock_category, :type => Mongoid::Boolean, :default => false
  field :last_active_mark, :type => Integer

  validates_presence_of :name, :node_id
# validates_uniqueness_of :name

  has_many :properties
  has_many :products
  has_many :csvfiles
  has_many :pairs # 多次导入记录
  has_many :resources # 有多张图片 区别于 prodcut


  belongs_to :node
  belongs_to :user
  belongs_to :last_edit_user, :class_name => 'User'

  counter_cache :name => :node, :inverse_of => :categories
  index :user_id => 1
  index :last_active_mark => -1

  scope :last_actived, desc(:last_active_mark)

  before_create :init_last_active_mark_on_create
  def init_last_active_mark_on_create
    self.last_active_mark = Time.now.to_i
  end

#  def update_last_edit
#    self.last_active_mark = Time.now.to_i
#  end

end
