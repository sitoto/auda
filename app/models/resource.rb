class Resource
  include Mongoid::Document
  field :name, type: String
  field :note, type: String

  mount_uploader :photo, PhotoUploader

  validates_presence_of :photo #name

end
