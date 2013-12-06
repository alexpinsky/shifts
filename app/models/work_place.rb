class WorkPlace < ActiveRecord::Base
	attr_accessible :name
	
	has_many :roles
	has_many :shifts

	validates_presence_of :name
end