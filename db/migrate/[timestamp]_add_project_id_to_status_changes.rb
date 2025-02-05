class AddProjectIdToStatusChanges < ActiveRecord::Migration[8.0]
  def change
    add_reference :status_changes, :project, null: false, foreign_key: true
    add_index :status_changes, :project_id
  end
end 