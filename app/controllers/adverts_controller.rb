class AdvertsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @adverts=current_user.adverts
  end
  def click
    @advert=Advert.find(params[:id])
    click=Click.new
    click.user=current_user
    click.advert=@advert
    click.save
    redirect_to @advert.url
  end
  def new
    @advert=Advert.new(params[:advert])
  end
  def create
    @advert=Advert.new(params[:advert])
    @advert.user=current_user
    if @advert.valid?
      @advert.save
      flash[:notice]="Advertisement created!"
      redirect_to :action=>:index
    else
      render :new
    end
  end
  def edit
    @advert=Advert.find(params[:id])
  end
  def update
    @advert=Advert.find(params[:id])
    if @advert.update_attributes(params[:advert])
      flash[:notice]="Advertisement updated!"
      redirect_to :action=>:index
    else
      render :edit
    end
  end
  def destroy
    @advert=Advert.find(params[:id])
    @advert.destroy
    redirect_to :action=>:index
  end
  #this report gathers impression/click data from a previous date to a max date
  def performance
    @advert     = Advert.find(params[:id])
    @start_date = Date.parse(params[:filters][:start_date]) rescue 1.month.ago
    @end_date   = Date.parse(params[:filters][:end_date])   rescue Time.now
    report_days = (@end_date-@start_date)/1.day
    @report_data={}
    #generate aggregate data

    @report_data['totals']                    = {}
    @report_data['totals']['impressions']     = @advert.impressions.between(@start_date,@end_date).count
    @report_data['totals']['clicks']          = @advert.clicks.between(@start_date,@end_date).count
    @report_data['totals']['impressions_day'] = @report_data['totals']['impressions']/report_days
    @report_data['totals']['clicks_day']      = @report_data['totals']['clicks']/report_days
    @report_data['totals']['conversion']      = 100.0*(@report_data['totals']['clicks'].to_f/@report_data['totals']['impressions'].to_f)
    #generate sereies data
    @report_data['series']                    = {}
    @report_data['series']['impressions']     = @advert.impressions.between(@start_date,@end_date).by_day
    @report_data['series']['clicks']          = @advert.clicks.between(@start_date,@end_date).by_day
    
    #correlate/merge keys for date series 
    @report_data['series']['merge']={}
    @report_data['series']['impressions'].each do |i|
      @report_data['series']['merge'][i.day]||={}
      @report_data['series']['merge'][i.day].update({'impressions'=>i.total})
    end
    @report_data['series']['clicks'].each do |c|
      @report_data['series']['merge'][c.day]||={}
      @report_data['series']['merge'][c.day].update({'clicks'=>c.total})
    end
    @graph_data={}
    
    #raise {'series'=>(@start_date.to_date..@end_date.to_date).collect {|d| d.strftime('%m/%d/%y'@report_data['series']['merge'].keys.inspect

    @graph_data['impressions']=(@start_date.to_date..@end_date.to_date).collect do |date|
      @report_data['series']['merge'][date.strftime("%Y-%m-%d")]['impressions'].to_i rescue  0
    end
    @graph_data['clicks']=(@start_date.to_date..@end_date.to_date).collect do |date|
      @report_data['series']['merge'][date.strftime("%Y-%m-%d")]['clicks'].to_i rescue  0
    end
  end
end
