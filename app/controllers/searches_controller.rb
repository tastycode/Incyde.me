require 'fastercsv'
class SearchesController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html,:csv,:xml,:json
  def index
    @searches=current_user.searches
  end
  def show
    @search=Search.find(params[:id])
    if current_user.can?("can_see_all_posts") 
      @posts=Post.matches_search(@search).all
    else
      @posts=Post.for_user(current_user).matches_search(@search).all
    end
    respond_with (@posts) do |format|
      format.html
      format.json { render :json=>@posts.collect(&:attributes) }
      format.xml  { render :xml=>@posts.collect(&:attributes)  }
      format.csv { render :layout=>false} 
    end
  end
  def new
    @search=Search.new
  end
  def create
    @search=Search.new(params[:search])
    @search.user=current_user
    if @search.valid?
      @search.save
      redirect_to :action=>:show,:id=>@search.id
    else

      render :new
    end
  end
  def edit
    @search=Search.find(params[:id])
  end 
  def update
    @search=Search.find(params[:id])
    if @search.update_attributes(params[:search])
      redirect_to :action=>:show,:id=>@search.id
    else
      render :edit
    end
  end
  def destroy
    begin
      @search=Search.find(params[:id])
      @search.destroy
    rescue 
      flash[:error]="Could not delete search, please ensure there are no advertisements associated with this search"
    end
    redirect_to :action=>:index
  end
end
