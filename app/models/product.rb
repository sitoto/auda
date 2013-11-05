class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  field :status, type: Integer , default: 0
  field :user_name, type: String
  field :ip, type: String

  belongs_to :category
  embeds_many :parameters
  belongs_to :pair
end
