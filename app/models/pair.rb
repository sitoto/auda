class Pair
  include Mongoid::Document
  include Mongoid::Timestamps

  field :category_id, type: String
  field :csvfile_id, type: String

  field :hash_pairs, type: Hash
  field :status, type: Integer

  belongs_to :category
  belongs_to :csvfile
  has_many :products
  belongs_to :user

end
