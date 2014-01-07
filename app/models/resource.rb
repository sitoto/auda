class Resource
  include Mongoid::Document
  field :name, type: String
  field :size, type: String
  field :note, type: String

  mount_uploader :photo, PhotoUploader
end
