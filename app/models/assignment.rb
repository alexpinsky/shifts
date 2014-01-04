class Assignment < ActiveRecord::Base
	belongs_to :workplace
	belongs_to :user
	belongs_to :shift

	validates_presence_of :workplace
  validates_presence_of :user
  validates_presence_of :shift
end