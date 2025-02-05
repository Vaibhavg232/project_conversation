class AddProjectIdToComments < ActiveRecord::Migration[8.0]
  def change
    add_column :comments, :project_id, :bigint
  end
end
