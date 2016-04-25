class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.date :starts_at
      t.references :students_tutor, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
