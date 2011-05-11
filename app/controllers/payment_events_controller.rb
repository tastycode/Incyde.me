class PaymentEventsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @payment_events=current_user.payment_events
  end
end
