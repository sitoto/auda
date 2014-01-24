class Temproduct
  include Mongoid::Document
  include Mongoid::Timestamps

  field :status, type: Integer , default: 0
  field :user_name, type: String
  field :ip, type: String
  field :last_active_mark, :type => Integer
  field :position, type: Integer, default: 0



  belongs_to :csvfile
  embeds_many :parameters
end
