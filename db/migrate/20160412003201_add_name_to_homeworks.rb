class AddNameToHomeworks < ActiveRecord::Migration
  def change
    add_column :homeworks, :name, :string
  end
end
