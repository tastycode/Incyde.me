class PaymentMethod < ActiveRecord::Base
  belongs_to :user
  has_many :payment_events
  validates_presence_of :card_number,:expires_at
  validates_numericality_of :card_number
  validates_length_of :card_number, :is=>16
  def hashed_card_number
    ("*"*8)+card_number[-4..-1].to_s
  end
end
