class Employment < ActiveRecord::Base
	belongs_to :work_place
	belongs_to :user
	belongs_to :role

	attr_accessible :role_id, :work_place_id, :user_id, :work_place, :role, :user

	validates_presence_of :work_place
  validates_presence_of :user
  validates_presence_of :role
end