class CreateAdverts < ActiveRecord::Migration
  def self.up
    create_table :adverts do |t|
      t.string :title
      t.string :body
      t.integer :user_id
      t.integer :search_id
      t.timestamps
    end
  end

  def self.down
    drop_table :adverts
  end
end
