class AddUrlToAdverts < ActiveRecord::Migration
  def self.up
    add_column :adverts,:url,:string
  end

  def self.down
    remove_column :adverts,:url
  end
end
