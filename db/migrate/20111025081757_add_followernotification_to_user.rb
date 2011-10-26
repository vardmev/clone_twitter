class AddFollowernotificationToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :follower_notification, :boolean, :default => true
  end

  def self.down
    remove_column :users, :follower_notification
  end
end
