class Resource
  include Mongoid::Document
  field :name, type: String
  field :note, type: String

  mount_uploader :photo, PhotoUploader

  validates_presence_of :photo #name

  has_and_belongs_to_many :products
  belongs_to :category



end
