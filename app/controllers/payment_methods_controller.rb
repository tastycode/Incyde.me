class PaymentMethodsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @payment_methods=current_user.payment_methods
  end
  def edit
    @payment_method=PaymentMethod.find(params[:id])
  end
  def update
    @payment_method=PaymentMethod.find(params[:id])
    @payment_method.update_attributes(params[:payment_method])
    if @payment_method.valid?
      @payment_method.save
      flash[:notice]="Payment method updated!"
      redirect_to :action=>:index
    else
      render :edit
    end
  end
  def new
    @payment_method=PaymentMethod.new
  end
  def create
    @payment_method=PaymentMethod.new(params[:payment_method])
    @payment_method.user=current_user
    if (@payment_method.valid?)
      @payment_method.save
      flash[:notice]="Payment method created!"
      redirect_to :action=>:index
    else
      render :new 
    end
  end
  def destroy
    @payment_method=PaymentMethod.find(params[:id])
    @payment_method.destroy
    redirect_to :action=>:index
  end

end
