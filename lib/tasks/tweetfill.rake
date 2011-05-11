task :copy_tweets => :environment do 
  require 'twitter'
  search_pos=Twitter::Search.new.
    language('en').
    no_retweets.
    positive.
    not_containing("twitter").
    not_containing('tweet').
    per_page(100)
  
  search_neg=Twitter::Search.new.
    language('en').
    no_retweets.
    negative.
    not_containing("twitter").
    not_containing('tweet').
    per_page(100)
  search_spr=Twitter::Search.new.
    language('en').
    geocode(37.2152778,-93.2980556,"100mi").
    no_retweets.
    not_containing("twitter").
    not_containing('tweet').
    per_page(100)
  User.all.each do |user| 
    results=[]
    3.times do
      results+= search_pos.fetch_next_page.select {|tweet| tweet.text[/@|#/].nil? && tweet.text.length>10} rescue []
      results+= search_neg.fetch_next_page.select {|tweet| tweet.text[/@|#/].nil? && tweet.text.length>10} rescue []
      results+= search_spr.fetch_next_page.select {|tweet| tweet.text[/@|#/].nil? && tweet.text.length>10} rescue []
    end

    results.each do |result|
      puts result['text']
      p=Post.new(:created_at=>result.created_at,:content=>result.text)
      p.save
      user.posts << p
    end
  end
end


task :randomize_dates => :environment do
  MIN_DATE=5.months.ago
  MAX_DATE=Time.now
  date_range=(MAX_DATE-MIN_DATE)/1.day 
  Post.all.each do |post|
    post.created_at=MIN_DATE+(rand*date_range)*1.day
    post.save
    puts post.created_at
  end

end
