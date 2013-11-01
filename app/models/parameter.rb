class Parameter
  include Mongoid::Document
  include Mongoid::Timestamps

  field :code, type: String
  field :name, type: String
  field :value, type: String
  field :position, type: Integer
  
  #validates_presence_of  :code
  #validates_uniqueness_of  :code

  embedded_in :product
  embedded_in :temproduct

  #  has_one :property


end
