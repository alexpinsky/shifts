class CreateShifts < ActiveRecord::Migration
  def change
  	create_table :shifts do |t|
      t.string  :name
      t.datetime  :start_time
      t.datetime  :end_time
      t.integer :role_id

      t.timestamps
    end
  end
end
