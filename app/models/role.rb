class Role < ActiveRecord::Base
	belongs_to :work_place
	has_many :shifts
	has_many :employments
	has_many :users, through: :employments

	validates_presence_of :name

	attr_accessible :name

	scope	:by_work_place, lambda { |work_place| where("roles.work_place_id = ?", work_place.id) }
end