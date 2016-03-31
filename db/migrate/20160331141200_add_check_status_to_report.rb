class AddCheckStatusToReport < ActiveRecord::Migration
  def change
    add_column :reports, :checked_status, :string
  end
end
