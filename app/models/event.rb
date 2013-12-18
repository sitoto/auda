class Event
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :username, type: String
  field :status, type: String
  field :note, type: String

  belongs_to :user

end
