class Category
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :alias, type: String
  field :note, type: String

  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :properties
  has_many :products
  has_many :csvfiles
  has_many :pairs
end
