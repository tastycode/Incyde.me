class AddHmtPermissions < ActiveRecord::Migration
  def self.up
    add_column :permissions_groups, :id, :primary_key
    add_column :permissions_users,:id,:primary_key
  end

  def self.down
    remove_column :permissions_groups, :id
    remove_column :permissions_groups, :id
  end
end
