class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name,:phone, :city, :state, :zip
  has_many :payment_methods
  has_many :payment_events
  has_many :posts
  has_many :adverts
  has_many :impressions
  has_many :searches
  has_many :user_permissions, :conditions=>{:enabled=>true}
  has_many :permissions, :through=>:user_permissions
  has_and_belongs_to_many :groups
  #returns the resolved permission tree for this user  
  def resolved_permissions
    groups_permissions=groups.collect(&:permissions).flatten.uniq
    {'group_permissions'=>groups_permissions,
    'user_permissions'=>permissions,
    'permissions'=>(groups_permissions+permissions).uniq}
  end
  #checks User#resolved_permissions for any permissions that match the key
  #==params
  #- <tt>key</tt> - String: The key column of the permissions table to check against resolved permissions
  def can?(key)
    resolved_permissions['permissions'].collect(&:key).include? key 
  end
  def to_s
    email
  end

  #Returns true if the user is a member of the group @key
  #==Params
  # - <tt>key</tt> - String: The key of the group that is being checked for membership against the user
  def member_of?(key)
    groups.collect(&:key).include? key 
  end

 
  #Groups by day (format is mm/dd/yy)
  def self.by_day
    select("date_format(created_at,'%Y-%m-%d') as day","count(*) as total")
    group("date_format(created_at,'%Y-%m-%d')").
    order("created_at")
  end
end
