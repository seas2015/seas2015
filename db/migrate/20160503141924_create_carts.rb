class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.string :name
      t.string :equip_id
      t.string :applicant

      t.timestamps null: false
    end
  end
end
