class Role < ActiveRecord::Base
	belongs_to :workplace
	has_many :shifts
	has_many :employments
	has_many :users, through: :employments

	validates_presence_of :name

	scope	:by_workplace, lambda { |workplace| where("roles.workplace_id = ?", workplace.id) }
end