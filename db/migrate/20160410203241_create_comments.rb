class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :text
      t.references :question, index: true, foreign_key: true
      t.string :user

      t.timestamps null: false
    end
  end
end
