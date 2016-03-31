class AddEquipTypeToReports < ActiveRecord::Migration
  def change
    add_column :reports, :equip_type, :string
  end
end
