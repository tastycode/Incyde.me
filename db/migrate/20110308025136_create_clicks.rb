class CreateClicks < ActiveRecord::Migration
  def self.up
    create_table :clicks do |t|
      t.integer :advert_id
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :clicks
  end
end
