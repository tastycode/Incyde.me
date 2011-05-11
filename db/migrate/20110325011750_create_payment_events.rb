class CreatePaymentEvents < ActiveRecord::Migration
  def self.up
    create_table :payment_events do |t|
      t.string :type
      t.decimal :amount
      t.string :notes
      t.integer :payment_method_id
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :payment_events
  end
end
