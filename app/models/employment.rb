class Employment < ActiveRecord::Base
	belongs_to :workplace
	belongs_to :user
	belongs_to :role

	attr_accessible :role_id, :workplace_id, :user_id, :workplace, :role, :user

	validates_presence_of :workplace
  validates_presence_of :user
  validates_presence_of :role
end