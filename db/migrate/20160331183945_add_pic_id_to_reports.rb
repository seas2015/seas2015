class AddPicIdToReports < ActiveRecord::Migration
  def change
    add_column :reports, :pic_id, :string
  end
end
