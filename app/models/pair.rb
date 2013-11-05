class Pair
  include Mongoid::Document
  include Mongoid::Timestamps

  field :category_id, type: String
  field :csvfile_id, type: String

  field :hash_paris, type: Hash
  field :status, type: Integer

  belongs_to :category
  has_one :csvfile
  has_many :product
end
