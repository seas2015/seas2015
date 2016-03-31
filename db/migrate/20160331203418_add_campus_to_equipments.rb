class AddCampusToEquipments < ActiveRecord::Migration
  def change
    add_column :equipment, :campus, :string
    add_column :equipment, :location, :string
  end
end
