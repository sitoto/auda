class Permission
  include Mongoid::Document
  field :action, type: String
  field :subject, type: String
  field :description, type: String

  has_and_belongs_to_many :users

end
