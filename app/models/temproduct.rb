class Temproduct
  include Mongoid::Document
  include Mongoid::Timestamps

  field :status, type: Integer , default: 0
  field :user_name, type: String
  field :ip, type: String

  belongs_to :csvfile
  embeds_many :parameters
end
