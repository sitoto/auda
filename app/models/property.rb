class Property
  include Mongoid::Document
  include Mongoid::Timestamps

  field :code, type: String
  field :name, type: String
  field :value, type: String
  field :alias, type: String #Array ,default: [] 
  field :position, type: Integer, default: 100

  validates_presence_of :name

  belongs_to :category
#  belongs_to :parameter
  belongs_to :user
end
