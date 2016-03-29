class AddProcessToEquipments < ActiveRecord::Migration
  def change
    add_column :equipment, :process, :string
  end
end
