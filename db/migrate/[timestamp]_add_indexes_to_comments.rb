class AddIndexesToComments < ActiveRecord::Migration[8.0]
  def change
    add_index :comments, :project_id
    add_index :comments, :parent_id
    add_foreign_key :comments, :projects
    add_foreign_key :comments, :comments, column: :parent_id
  end
end 