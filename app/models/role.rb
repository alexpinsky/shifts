class Role < ActiveRecord::Base
	attr_accessible :name

	belongs_to :work_place
	has_many :shifts

	validates_presence_of :name
end