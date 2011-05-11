class Advert < ActiveRecord::Base
  belongs_to :user
  belongs_to :search

  has_many :clicks, :dependent=>:destroy
  has_many :impressions, :dependent=>:destroy
  validates_associated :search
  validates_presence_of :title,:body,:url,:search_id
end
