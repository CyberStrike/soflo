class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.text :about
      t.string :url
      t.string :meetup_id

      t.timestamps null: false
    end
  end
end
