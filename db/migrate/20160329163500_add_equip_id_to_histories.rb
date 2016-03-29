class AddEquipIdToHistories < ActiveRecord::Migration
  def change
    add_column :histories, :equip_id, :string
    add_column :histories, :detail, :string
  end
end
