class ChangesToTasks < ActiveRecord::Migration[6.1]
  def change
    remove_column :tasks, :date
    add_column :tasks, :due_date, :date, null: false
  end
end
