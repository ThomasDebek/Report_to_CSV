class Product < ApplicationRecord


  validates :title, :description, :price, presence: true
  validates :title, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }








  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Product.create! row.to_hash
    end
  end



  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end



end
