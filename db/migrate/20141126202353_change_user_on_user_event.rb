class ChangeUserOnUserEvent < ActiveRecord::Migration
  def change
    change_column :user_events, :user_id, :integer, null: false
  end
end
