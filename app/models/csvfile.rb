class Csvfile
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :creater, type: String
  field :size, type: String
  field :status, type: Integer, default: 0
  validates_presence_of :name


  has_many :temproducts
  belongs_to :category
  belongs_to :pair

end
