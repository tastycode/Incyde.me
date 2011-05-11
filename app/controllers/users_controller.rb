class UsersController < ApplicationController
  before_filter :authenticate_user!
  def index
    if params[:group_id].nil?
      @users=User.all
    else
      @users=Group.find(params[:group_id]).users
    end
  end
  def edit
    @user=User.find(params[:id])
  end
  def update
    @user=User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to :action=>:index
    else
      render :edit
    end
  end
  def new
    @user=User.new
  end
  def create
    @user=User.new(params[:user])
    if @user.valid?
      @user.save
      redirect_to :action=>:index
    else
      render :new
    end
  end
  def destroy
    @user=User.find(params[:id])
    @user.destroy
  end
  def activity
    
    @start_date   = Date.parse(params[:filters][:start_date]) rescue 1.month.ago
    @end_date     = Date.parse(params[:filters][:end_date])   rescue Time.now
    signups       = User.where(["created_at>? and created_at<?",@start_date,@end_date])
    signups_count = signups.count
    posts         = Post.between(@start_date,@end_date)
    posts_count   = posts.count
    
    report_days   = (@end_date.to_datetime.to_i-@start_date.to_datetime.to_i)/1.day

    @report_data={}
    #generate aggregate data
    
    @report_data['totals']                = {}
    @report_data['totals']['signups']     = signups_count
    @report_data['totals']['posts']       = posts_count
    @report_data['totals']['signups_day'] = signups_count/report_days
    @report_data['totals']['posts_day']   = posts_count/report_days


    #generate sereies data
    @report_data['series']                = {}
    @report_data['series']['posts']       = posts.by_day
    @graph_data= {}
    @graph_data['posts']=(@start_date.to_date..@end_date.to_date).collect do |date|
      @report_data['series']['posts'].detect {|p| p.day==date.strftime("%Y-%m-%d") }.total.to_i rescue 0
    end
    frequencies                           = Post.word_frequency(posts).to_a.sort {|(ka,va),(kb,vb)| va<=>vb}[-30..-1]
    @report_data['series']['frequencies'] = frequencies.collect{|(word,freq)| {'word'=>word,'total'=>freq}}
    
  end
end
