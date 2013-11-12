class Csvfile
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :creater, type: String
  field :size, type: String
  field :status, type: Integer, default: 0
  validates_presence_of :name


  has_many :temproducts
  belongs_to :pair

  belongs_to :category, :inverse_of => :csvfiles
  belongs_to :user, :inverse_of => :csvfiles

end
