class AddStatusAndTrasitionsToTask < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :status, :string
    add_column :tasks, :transitions, :string, array: true, default: []
  end
end
