class Click < ActiveRecord::Base
  belongs_to :advert
  belongs_to :user
  #Named scope to filter clicks between @date_start and @date_end
  #==Params
  # -<tt>date_start</tt> - Datetime: The oldest date to pull clicks from
  # -<tt>date_end</tt> - Datetime: The newest date to pull clicks from
  def self.between(date_start,date_end)
    where(["created_at>? and created_at<?",date_start,date_end])
  end
  #Groups by day (format is mm/dd/yy)
  def self.by_day
    select("date_format(created_at,'%Y-%m-%d') as day","count(*) as total").
    group("date_format(created_at,'%Y-%m-%d')").
    order("created_at")
  end
end
