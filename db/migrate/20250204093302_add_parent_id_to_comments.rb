class AddParentIdToComments < ActiveRecord::Migration[8.0]
  def change
    add_column :comments, :parent_id, :bigint
  end
end
