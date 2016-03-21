class CreateEquipment < ActiveRecord::Migration
  def change
    create_table :equipment do |t|
      t.string :equip_id
      t.string :name
      t.string :status

      t.timestamps null: false
    end
  end
end
