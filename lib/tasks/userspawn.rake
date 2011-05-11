desc "Generate random user data for testing reports"
task :spawn_users => :environment do 
  MAX_COUNT=300
  MIN_START=5.months.ago
  MAX_START=1.day.ago
  day_range=(MAX_START-MIN_START)/1.day
  MAX_COUNT.times do
    fname                   = Forgery::Name.first_name
    lname                   = Forgery::Name.last_name
    uname                   = fname[0].chr().downcase+lname
    email                   = uname+"@"+Forgery::Internet.domain_name
    city                    = Forgery::Address.city
    state                   = Forgery::Address.state_abbrev
    zip                     = Forgery::Address.zip
    phone                   = Forgery::Address.phone.gsub(/[^0-9]/,'')[1..-1]
    created_at              = MIN_START+(rand*day_range)*1.day
    puts created_at.inspect
    last_sign_in_range      = (MAX_START-created_at)/1.day
    last_sign_in_at         = created_at+(rand*last_sign_in_range)*1.day
    u=User.new(
      :email      => email,
      :first_name => fname,
      :last_name  => lname,
      :email      => email,
      :phone      => phone,
      :city       => city,
      :state      => state,
      :zip        => zip
    )
    u.password        = "password"
    u.save
    u.created_at      = created_at
    u.last_sign_in_at = last_sign_in_at
    u.save
    puts u.inspect
  end
end
