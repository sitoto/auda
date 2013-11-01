class Csvfile
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :creater, type: String
  field :size, type: String

  has_many :temproducts
end
