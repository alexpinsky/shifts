class Employment < ActiveRecord::Base
	belongs_to :workplace
	belongs_to :user
	belongs_to :role

	validates_presence_of :workplace
  validates_presence_of :user
  validates_presence_of :role
end