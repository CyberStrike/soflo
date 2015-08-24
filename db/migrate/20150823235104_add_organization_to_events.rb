class AddOrganizationToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :organization, index: true, foreign_key: true
  end
end
