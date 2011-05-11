class HomeController < ApplicationController
  def exception
    5/0
  end
  def index
    if user_signed_in?
      @posts=current_user.posts.find(:all,:limit=>20,:order=>"created_at desc")
      posting_listing
    end
  end
end
