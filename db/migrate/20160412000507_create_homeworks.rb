class CreateHomeworks < ActiveRecord::Migration
  def change
    create_table :homeworks do |t|
      t.string :description
      t.string :attachment
      t.string :stg
      t.references :students_tutor, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
