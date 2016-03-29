class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.string :action
      t.string :action_id
      t.string :user_id
      t.string :user_name

      t.timestamps null: false
    end
  end
end
