class CreateStatusChanges < ActiveRecord::Migration[8.0]
  def change
    create_table :status_changes do |t|
      t.string :old_status
      t.string :new_status

      t.timestamps
    end
  end
end
