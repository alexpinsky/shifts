class Shift < ActiveRecord::Base
	belongs_to :role
	has_many :users, through: :role

	attr_accessible :role_id
end