class ChangeEventTypeColumnnName < ActiveRecord::Migration
  def self.up
    rename_column :payment_events, :type, :etype
  end

  def self.down
    rename_column :payment_events, :etype, :type
  end
end
