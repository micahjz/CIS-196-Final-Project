class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :text
      t.references :students_tutor, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
