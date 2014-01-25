class Workplace < ActiveRecord::Base
	has_many :roles
	has_many :shifts, through: :roles
	has_many :employments, dependent: :destroy
	has_many :users, through: :employments

	after_commit :create_default_roles, on: :create

	def add_employee!(user)
		employee_role = self.roles.employee.first
		Employment.create!(user: user, role: employee_role, workplace: self)
	end

private

	def create_default_roles
		AdminRole.create(workplace: self)
		EmployeeRole.create(workplace: self)
	end
end