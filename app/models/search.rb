class Search < ActiveRecord::Base
  belongs_to :user
  acts_as_taggable 
  has_many :adverts,:dependent=>:restrict
  validates_presence_of :query
  #Find all incytes that have the query text in them
  def to_s
    "#{id}:#{query}"
  end
  def execute
   Post.where(["instr(content,?)",query])
  end
end
