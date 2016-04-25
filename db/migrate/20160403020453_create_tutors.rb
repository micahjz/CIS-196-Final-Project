class CreateTutors < ActiveRecord::Migration
  def change
    create_table :tutors do |t|
      t.string :name
      t.string :password_hash
      t.string :email
      t.string :field

      t.timestamps null: false
    end
  end
end
