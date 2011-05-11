class Permission < ActiveRecord::Base
  has_many :group_permissions
  has_many :groups, :through=>:group_permissions
  has_many :user_permissions
  has_many :users, :through=>:user_permissions
  validates_uniqueness_of :key
  validates_presence_of :title
end
