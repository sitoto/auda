class Parameter
  include Mongoid::Document
  include Mongoid::Timestamps

  field :code, type: String
  field :name, type: String
  field :value, type: String
  field :position, type: Integer
  
  validates_presence_of :name, :code
  validates_uniqueness_of :name, :code

  embedded_in :product


end
