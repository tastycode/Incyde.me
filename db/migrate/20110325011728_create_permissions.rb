class CreatePermissions < ActiveRecord::Migration
  def self.up
    create_table :permissions do |t|
      t.string :key, :length=>32
      t.string :title
      t.timestamps
    end
    create_table :permissions_users, :id=>false do |t|
      t.integer :permission_id
      t.integer :user_id
      t.boolean :enabled
    end
    create_table :permissions_groups, :id=>false do |t|
      t.integer :permission_id
      t.integer :group_id
      t.boolean :enabled
    end
  end

  def self.down
    drop_table :permissions
    drop_table :permissions_users
    drop_table :permissions_groups
  end
end
