class ChangeGroupTableNamesAgain < ActiveRecord::Migration
  def self.up
    rename_table :users_permissions, :user_permissions
    rename_table :groups_permissions, :group_permissions
  end

  def self.down
    rename_table :user_permissions, :users_permissions
    rename_table :group_permissions, :groups_permissions
  end
end
