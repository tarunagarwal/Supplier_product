class Supplier < ApplicationRecord
	has_many :supplier_products, dependent: :delete_all
	has_many :products, through: :supplier_products
	
	# def self.import_data
	# 	supplier_arr = []
	# 	CSV.foreach('public/suppliers.csv', headers: true) do |row|
	# 		row = row.to_h
	#  		supplier_arr << Supplier.new(id: row["supplier_id"], name: row["supplier_name"])
	# 	end
	# 	Supplier.import supplier_arr
	# end

	def self.import_new_data(suppliers)
		suppliers_arr = []
		suppliers.each do |row|
			suppliers_arr << Supplier.new(row)
		end
	    Supplier.import suppliers_arr
	end

	def supplier_active_products
		self.products.where("supplier_products.active = ?", true).length
	end		

	def products_count
		self.products.length 
	end 
end
