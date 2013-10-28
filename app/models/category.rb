class Category
  include Mongoid::Document
  field :name, type: String
  field :note, type: String
end
