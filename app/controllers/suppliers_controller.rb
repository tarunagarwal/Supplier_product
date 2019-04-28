class SuppliersController < ApplicationController

  def index
	  @supplier = Supplier.includes(:products)
  end

  def import_new_data
  	delete_supplier_product_data = SupplierProduct.delete_all
  	delete_supplier_data = Supplier.delete_all
  	delete_product_data = Product.delete_all
  	file = params[:file]
    supplier_products = CSV.read(file.path, headers: true)
    suppliers = supplier_products.map{|row| {id: row["supplier_id"], name: row["supplier_name"]}}.uniq
    Supplier.import_new_data(suppliers)
    products = supplier_products.map{|row| {id: row["product_id"], title: row["product_title"], category: row["category"], price: row["price"]}}.uniq
    Product.import_new_data(products)
    supplier_products = supplier_products.map{|row| {product_id: row["product_id"], supplier_id: row["supplier_id"], active: row["is_active"]}}
    SupplierProduct.import_new_data(supplier_products)
    redirect_to root_path
  end

  def show  	
    @supplier = Supplier.includes(:products).find_by_id(params[:id])
    if params[:inactive] == "false"
      @inactive = false
    	@products = @supplier.products.where("supplier_products.active = ?", true)
    else
      @inactive = true
      @products = @supplier.products
    end
  end

end