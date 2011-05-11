class ApplicationController < ActionController::Base
  protect_from_forgery

#  unless config.consider_all_requests_local
    #rescue_from ActionController::RoutingError, :with=>:render_not_found
    #rescue_from Exception, :with=>:render_error
    #rescue_from ActiveRecord::RecordNotFound, :with=> :render_not_found
  #end
  def posting_listing
    #find any searches that match the posts in this list
    searches=[]
    @posts.each do |post|
      searches << Search.all.select do |search|
        post.matches_search(search)
      end
    end
    #finbd any maatching adverts
    @adverts=searches.flatten.uniq.collect do |search|
      search.adverts
    end.flatten[0..5]
    
    #log impressions for the matching adverts
    @adverts.each do |advert|
      Impression.new({:user=>current_user,:advert=>advert}).save
    end
  end
  def render_error
    render :template=>"errors/internal_server_error", :status=>500
  end
  def render_not_found
    render :template=>"errors/not_found", :status=>404
  end
#  def error
#    render :text=>"
#  end
end
