class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  field :status, type: Integer , default: 0
  field :user_name, type: String
  field :ip, type: String
  field :last_active_mark, :type => Integer

  belongs_to :category
  embeds_many :parameters
  belongs_to :pair
  belongs_to :user

  belongs_to :last_edit_user, :class_name => 'User'
  belongs_to :last_agree_user, :class_name => 'User'

  index :status => 1

  scope :draft, -> { where(status: 0) }
  scope :ready, -> { where(status: 1) }
  scope :done, -> { where(status: 2) }
  scope :not_done, -> { where(:status.lt => 2) }


  before_create :init_last_active_mark_on_create
  def init_last_active_mark_on_create
    self.last_active_mark = Time.now.to_i
  end

 
end
