class Shift < ActiveRecord::Base
	belongs_to :role
	has_many :assignments
	has_many :available_users, through: :role, source: :users
	has_many :assigned_users, through: :assignments, source: :user

	attr_accessible :role_id, :start_time, :end_time
end