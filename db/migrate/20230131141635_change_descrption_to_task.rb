class ChangeDescrptionToTask < ActiveRecord::Migration[6.1]
  def change
    remove_column :tasks, :descrption
    add_column :tasks, :description, :text
  end
end
