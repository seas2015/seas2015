class AddQrIdToEquipment < ActiveRecord::Migration
  def change
    add_column :equipment, :qr_id, :string
  end
end
