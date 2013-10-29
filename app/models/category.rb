class Category
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :note, type: String

  validates_presence_of :name
  validates_uniqueness_of :name

  embeds_many :properties
end
