class CreateEquipment < ActiveRecord::Migration
  def change
    create_table :equipment do |t|
      t.string :name
      t.string :equip_id
      t.date :buy_date
      t.string :brand
      t.string :note
      t.date :exp
      t.string :status
      t.string :serial
      t.float :price
      t.string :pic_id
      t.string :ownby

      t.timestamps null: false
    end
  end
end
