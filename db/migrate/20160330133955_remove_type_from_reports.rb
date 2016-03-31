class RemoveTypeFromReports < ActiveRecord::Migration
  def change
    remove_column :reports, :type, :string
  end
end
