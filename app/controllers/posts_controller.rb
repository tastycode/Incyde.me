class PostsController < ApplicationController
  before_filter :authenticate_user!

  def create
    p=Post.new(params[:post])
    p.user_id=current_user.id
    if p.valid?
      p.save
      redirect_to :controller=>:home, :action=>:index
    else
      flash[:error]="The post contains invalid content. Ensure that your post is longer than 0 characters"
      redirect_to :controller=>:home,:action=>:index
    end
  end
end
