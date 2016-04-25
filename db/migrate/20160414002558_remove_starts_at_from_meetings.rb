class RemoveStartsAtFromMeetings < ActiveRecord::Migration
  def change
    remove_column :meetings, :starts_at, :date
  end
end
