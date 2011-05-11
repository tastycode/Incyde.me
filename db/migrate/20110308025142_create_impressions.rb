class CreateImpressions < ActiveRecord::Migration
  def self.up
    create_table :impressions do |t|
      t.integer :advert_id
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :impressions
  end
end
