class CreateRoles < ActiveRecord::Migration
  def change
  	create_table :roles do |t|
      t.string  :name
      t.integer :workplace_id
      t.string :type

      t.timestamps
    end
  end
end
