
desc "Generate activity for clicks/impressions"
task :generate_random_activity => :environment do   
	MIN_DATE         = 5.months.ago
	MAX_DATE         = Time.now
	MAX_COUNT        = 5120
	users            = User.all
	ads              = Advert.all
	date_range_count = ((MAX_DATE-MIN_DATE)/(3600*24)).to_i #number of seconds in a day

	#generate random probabilities for each ad 
	ad_conversion_rates=(0...ads.length).to_a.collect {|ad_i| 
		(rand*15)+1
	}
	1.upto(MAX_COUNT) do 
		user     = users[((rand*users.length)).floor]
		ad       = ads[(rand*ads.length).floor]
		rand_day = ((rand*date_range_count)+1) #no floor for time randomization
		rand_date = MIN_DATE+(rand_day.days)+(3600*24*rand)
		i = Impression.new(
			:advert=>ad,
			:user=>user,
			:created_at=>rand_date
		)	
		i.save 
		puts i.inspect
		#determine whether this random data point has a click for this ad
		is_click=false
			#generate a random number between 1 and 100
			rand_n=(rand*100)+1
			#the conversion likelihood for this ad
			begin
				prob_conv=ad_conversion_rates[ads.index(ad)]
			rescue
				puts ad_conversion_rates.inspect
				puts ads.index(ad)
				puts "Current Ad: "+ad.inspect
				puts "All Ads Ids: "+(ads.collect(&:id)*",")
				exit
			end
			#if the random number is under the probability then flag for click
			is_click=true if rand_n<prob_conv
		if is_click
			c=Click.new(
				:created_at=>i.created_at,
				:advert=>ad,
				:user=>user
			)
			c.save
			puts c.inspect
		end			

	end
  

end
