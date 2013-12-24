require 'roo'
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

  #def init(attributes = {})
  #  attributes.each { |name, value| send("#{name}=", value) }
  #end

  def import_temp
    imported_products
    true
=begin
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
=end
  end

  def imported_products
#    @imported_products ||= load_imported_products
#    csv_rows = CSV.parse(file_data)
    spreadsheet = open_spreadsheet
    header = spreadsheet.row(1)

    (2..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]

        product =  Temproduct.new
        row.to_hash.each_with_index do |pname, value|
          parameter = Parameter.new(name: pname, value: value)
          product.parameters << parameter
        end
        product.csvfile = @csvfile
        product.save

      #     product = Product.find_by_id(row["id"]) || Product.new
      #     product.attributes = row.to_hash.slice(*Product.accessible_attributes)
      #     product
    end
=begin
    unstandtitle = [] 
    csv_rows.each_with_index do  |row, i|
      if i == 0
        unstandtitle = row 
        next
      else
        product =  Temproduct.new
        unstandtitle.each_with_index do |pname, j|
          parameter = Parameter.new(name: pname, value: row[j])
          product.parameters << parameter
        end
        product.csvfile = @csvfile
        product.save

      end 
    end
=end
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
    case File.extname(source.filename)
    when ".csv" then Roo::CSV.new(source.path,csv_options: {col_sep: ",", encoding: Encoding::ISO_8859_1})
    when ".xls" then Roo::Excel.new(source.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(source.path, nil, :ignore)
    else raise "Unknown file type: #{source.filename}"
    end
  end

end
