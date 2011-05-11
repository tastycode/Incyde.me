class Group < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :group_permissions, :conditions=>{:enabled=>true}, :dependent=>:destroy
  has_many :permissions, :through=>:group_permissions
  validates_uniqueness_of :key
  validates_presence_of :title

end
