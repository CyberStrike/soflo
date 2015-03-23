class CreateLocationEvents < ActiveRecord::Migration
  def change
    create_table :location_events do |t|
      t.references :location, index: true
      t.references :event, index: true

      t.timestamps
    end
  end
end
