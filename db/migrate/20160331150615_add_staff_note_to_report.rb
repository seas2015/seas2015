class AddStaffNoteToReport < ActiveRecord::Migration
  def change
    add_column :reports, :staff_note, :string
  end
end
