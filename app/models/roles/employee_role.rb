class EmployeeRole < Role
	after_initialize :set_defaults

private

	def set_defaults
		self.name ||= self.class.name.underscore 
	end
end