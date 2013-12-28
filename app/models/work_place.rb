class WorkPlace < ActiveRecord::Base
	attr_accessible :name
	
	has_many :roles
	has_many :shifts, through: :roles
	has_many :employments, dependent: :destroy
	has_many :users, through: :employments

	validates_presence_of :name
end