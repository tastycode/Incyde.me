class ChangeGroupTableNames < ActiveRecord::Migration
  def self.up
    rename_table :permissions_groups, :groups_permissions
    rename_table :permissions_users, :users_permissions
  end

  def self.down
    rename_table :groups_permissions, :permissions_groups
    rename_table :users_permissions, :permissions_users
  end
end
