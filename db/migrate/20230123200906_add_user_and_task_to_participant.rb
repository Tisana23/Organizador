class AddUserAndTaskToParticipant < ActiveRecord::Migration[6.1]
  def change
    add_reference :participants, :user, null: false, foreign_key: true
    add_reference :participants, :task, null: false, foreign_key: true

    add_column :participants, :role, :integer
  end
end