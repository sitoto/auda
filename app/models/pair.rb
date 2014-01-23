class Pair
  include Mongoid::Document
  include Mongoid::Timestamps

  field :category_id, type: String
  field :csvfile_id, type: String

  field :hash_pairs, type: Hash
  field :status, type: Integer, default: 0
  #status 0 ； 1： delete draft product
  field :note, type: String

  belongs_to :category
  belongs_to :csvfile
  has_many :products
  belongs_to :user

end
