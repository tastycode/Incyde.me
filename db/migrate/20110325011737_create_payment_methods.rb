class CreatePaymentMethods < ActiveRecord::Migration
  def self.up
    create_table :payment_methods do |t|
      t.string :card_number
      t.date :expires_at
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :payment_methods
  end
end
