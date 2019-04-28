class SupplierProduct < ApplicationRecord
	belongs_to :product 
	belongs_to :supplier

	require 'csv'
	require 'activerecord-import/base'	
	
	# def self.import_data
	# 	supplier_products_arr = []
	# 	CSV.foreach('public/supplier_products.csv', headers: true) do |row|
	# 		row = row.to_h
	#  		supplier_products_arr << SupplierProduct.new(product_id: row["product_id"], supplier_id: row["supplier_id"], active: row["is_active"])
	# 	end
	# 	SupplierProduct.import supplier_products_arr
	# end

	def self.import_data_into_tables
		supplier_products = CSV.read("public/supplier_products.csv", headers: true)
	    suppliers = supplier_products.map{|row| {id: row["supplier_id"], name: row["supplier_name"]}}.uniq
	    Supplier.import_new_data(suppliers)
	    products = supplier_products.map{|row| {id: row["product_id"], title: row["product_title"], category: row["category"], price: row["price"]}}.uniq
	    Product.import_new_data(products)
	    supplier_products = supplier_products.map{|row| {product_id: row["product_id"], supplier_id: row["supplier_id"], active: row["is_active"]}}
	    SupplierProduct.import_new_data(supplier_products)
	end

	def self.import_new_data(supplier_products)
		supplier_products_arr = []
		supplier_products.each do |row|
			supplier_products_arr << SupplierProduct.new(row)
		end
	    SupplierProduct.import supplier_products_arr
	end
end
