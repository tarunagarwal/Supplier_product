class ImportCsvDataToTables < ActiveRecord::Migration[5.2]
  def change
  	SupplierProduct.import_data_into_tables
  end
end
