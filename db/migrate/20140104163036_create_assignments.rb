class CreateAssignments < ActiveRecord::Migration
  def change
  	create_table :assignments do |t|
      t.integer :workplace_id
      t.integer :user_id
      t.integer :shift_id

      t.timestamps
    end
  end
end
