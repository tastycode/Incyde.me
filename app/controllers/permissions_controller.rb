class PermissionsController < ApplicationController
  before_filter :authenticate_user!
  def index
    if params[:group_id].nil?
      @permissions=Permission.all
    else
      @permissions=Group.find(params[:group_id]).permissions
    end
  end
  def new
    @permission=Permission.new
  end
  def create
    @permission=Permission.new(params[:permission])
    if @permission.valid?
      @permission.save
      redirect_to :action=>:index
    else
      render :new
    end
  end
  def edit
    @permission=Permission.find(params[:id])
  end
  def update

    @permission=Permission.find(params[:id])
    if @permission.update_attributes(params[:permission])
      redirect_to :action=>:index
    else
      render :edit
    end
  end
  def destroy
    Permission.find(params[:id]).destroy
    redirect_to :action=>:index
  end
end

