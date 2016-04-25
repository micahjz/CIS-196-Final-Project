class AddStartToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :start, :datetime
  end
end
