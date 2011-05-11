class GroupsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @groups=Group.all
  end
  def add_user
    @user=User.find(params[:user_id])
    @group=Group.find(params[:id])
    @group.users << @user
    redirect_to :controller=>:users,:action=>:index,:group_id=>@group.id
  end
  def remove_user
    @user=User.find(params[:user_id])
    @group=Group.find(params[:id])
    @group.users.delete(@user)
    redirect_to :controller=>:users,:action=>:index,:group_id=>@group.id
  end
  def add_permission
    @group=Group.find(params[:id])
    @permission=Permission.find(params[:permission_id])
    gp=GroupPermission.find_or_create_by_group_id_and_permission_id(@group.id,@permission.id)
    gp.enabled=true
    gp.save
    redirect_to :controller=>:permissions,:action=>:index,:group_id=>@group.id
  end
  def remove_permission
    @group=Group.find(params[:id])
    @permission=Permission.find(params[:permission_id])
    gp=GroupPermission.find_or_create_by_group_id_and_permission_id(@group.id,@permission.id)
    gp.enabled=false
    gp.save
    redirect_to :controller=>:permissions,:action=>:index,:group_id=>@group.id
  end
  def new
    @group=Group.new
  end
  def create
    @group=Group.new(params[:group])
    if @group.valid?
      @group.save
      redirect_to :action=>:index
    else
      render :new
    end
  end
  def edit
    @group=Group.find(params[:id])
  end
  def update
    @group=Group.find(params[:id])
    if @group.update_attributes(params[:group])
      redirect_to :action=>:index
    else
      render :edit
    end
  end
  def destroy

    if Group.find(params[:id]).destroy
      redirect_to :index
    else
      redirect_to :back    
    end
  end
end
