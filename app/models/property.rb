class Property
  include Mongoid::Document
  field :code, type: String
  field :name, type: String
  field :value, type: String
  field :position, type: Integer
end
