class AddedUserColumns < ActiveRecord::Migration
  def self.up
    add_column :users, :company , :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone, :string
    add_column :users, :city, :string
    add_column :users, :state, :string, :limit=>2
    add_column :users, :zip, :string, :limit=>10
  end

  def self.down
    remove_column :users, :company
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :phone
    remove_column :users, :city
    remove_column :users, :state
    remove_column :users, :zip
  end
end
