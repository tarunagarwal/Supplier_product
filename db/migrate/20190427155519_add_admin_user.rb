class AddAdminUser < ActiveRecord::Migration[5.2]
  def change
  	User.create(name: "admin", email: "admin@gmail.com", password: "admin123", password_confirmation: "admin123", role: "admin", city: "noida")
  end
end
