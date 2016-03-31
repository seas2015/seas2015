class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :title
      t.string :type
      t.string :note
      t.string :user_name
      t.string :user_id
      t.string :equip_id

      t.timestamps null: false
    end
  end
end
