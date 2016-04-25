class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.string :password_hash
      t.string :email

      t.timestamps null: false
    end
  end
end
