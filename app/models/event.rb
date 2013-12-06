class Event
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :user_id, type: String
  field :user_name, type: String
  field :status, type: String
  field :note, type: String

end
