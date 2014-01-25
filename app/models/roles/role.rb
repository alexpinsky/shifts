class Role < ActiveRecord::Base
	belongs_to :workplace
	has_many :shifts, dependent: :destroy
	has_many :employments, dependent: :destroy
	has_many :users, through: :employments

	validates_presence_of :name, if: :custom_role?
	validates_uniqueness_of :type, scope: :workplace_id, unless: :custom_role?

	scope :by_workplace, -> (workplace) { where("roles.workplace_id = ?", workplace.id) }
	scope :custom, -> { where("roles.type = 'Role'") }
	scope :employee, -> { where("roles.type = 'EmployeeRole'") }

	def custom_role?
		self.class.name == "Role"
	end
end