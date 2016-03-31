class AddActionToReports < ActiveRecord::Migration
  def change
    add_column :reports, :action_needed, :string
  end
end
