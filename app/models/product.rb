class Product < ApplicationRecord
	has_many :supplier_products, dependent: :delete_all
	has_many :suppliers, through: :supplier_products
	
	# def self.import_data
	# 	product_arr = []
	# 	CSV.foreach('public/products.csv', headers: true) do |row|
	# 		row = row.to_h
	#  		product_arr << Product.new(id: row["product_id"], title: row["product_title"], category: row["category"], price: row["price"])
	# 	end
	# 	Product.import product_arr
	# end


	def self.import_new_data(products)
		products_arr = []
		products.each do |row|
			products_arr << Product.new(row)
		end
	    Product.import products_arr
	end

end
