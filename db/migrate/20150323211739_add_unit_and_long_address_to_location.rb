class AddUnitAndLongAddressToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :unit, :string
    add_column :locations, :long_address, :string
  end
end
