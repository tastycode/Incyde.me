class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :password
      t.string :company
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :city
      t.string :state, :length=>2
      t.string :zip, :length=>5
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
