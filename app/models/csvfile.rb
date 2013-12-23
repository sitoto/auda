class Csvfile
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :creater, type: String
  field :size, type: String
  field :status, type: Integer, default: 0

  mount_uploader :source, SourcefileUploader

  validates_presence_of :source #name


  has_many :temproducts
  belongs_to :pair

  belongs_to :category, :inverse_of => :csvfiles
  belongs_to :user, :inverse_of => :csvfiles

  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def save
    if imported_products.map(&:valid?).all?
      imported_products.each(&:save!)
      true
    else
      imported_products.each_with_index do |product, index|
        product.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      false
    end
  end

  def imported_products
    @imported_products ||= load_imported_products
  end

  def load_imported_products
    spreadsheet = open_spreadsheet
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      #     product = Product.find_by_id(row["id"]) || Product.new
      #     product.attributes = row.to_hash.slice(*Product.accessible_attributes)
      #     product
    end
  end

  def open_spreadsheet
    case File.extname(source.original_filename)
    when ".csv" then Csv.new(source.path, nil, :ignore)
    when ".xls" then Excel.new(source.path, nil, :ignore)
    when ".xlsx" then Excelx.new(source.path, nil, :ignore)
    else raise "Unknown file type: #{source.original_filename}"
    end
  end

end
