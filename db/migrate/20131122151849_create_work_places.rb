class CreateWorkPlaces < ActiveRecord::Migration
  def change
  	create_table :work_places do |t|
      t.string  :name

      t.timestamps
    end
  end
end
