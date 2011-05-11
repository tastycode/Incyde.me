class Post < ActiveRecord::Base
  acts_as_taggable
  belongs_to :user
  validates_presence_of :content
  #Determines if this post matches the search passed aS S 
  #==Params
  # - <tt>s</tt> - Search to match against

  def matches_search(s)
    content.upcase.scan(s.query.upcase).length>0
  end

  #Filters for posts matching this search
  def self.matches_search(s)
    where(["instr(content,?)",s.query])
  end

  #Filters for posts matching the given user
  #==Params
  # - <tt>u</tt> - User: to match against
  def self.for_user(u)
    where(:user_id=>u.id)
  end

  #Takes post list and produces frequency data
  #App configurable exclusion list
  def self.word_frequency(posts)
    exclusions=APPCONFIG['word_frequency_exclusions']
    frequencies={}
    posts.each { |post|
     words=post.content.gsub(/[^a-zA-Z ]/,'').split(/\b/).select{|s| s.strip.length>APPCONFIG['word_frequency_minlength']}.collect(&:downcase)
     words.each { |word|
      frequencies[word]||=0
      frequencies[word]+=1
     }
    }
    exclusions.each { |word|
      frequencies.delete(word) 
    }
    frequencies.keys.each {|word|
      frequencies.delete(word) if frequencies[word]<=1 
    }
    frequencies
  end

  #Named scope to filter posts between @date_start and @date_end
  #==Params
  # -<tt>date_start</tt> - Datetime: The oldest date to pull posts from
  # -<tt>date_end</tt> - Datetime: The newest date to pull posts from
  def self.between(date_start,date_end)
    where(["created_at>? and created_at<?",date_start,date_end])
  end
  
  #Groups by day (format is mm/dd/yy)
  def self.by_day
    select("date_format(created_at,'%Y-%m-%d') as day","count(*) as total","count(*)/24.0 as posts_per_hour").
    group("date_format(created_at,'%Y-%m-%d')").
    order("created_at")
  end
end
