class RolesController < ApplicationController
	before_filter :set_workplace
	
	def index
		@roles = @workplace.roles.includes(:users)
	end

	def new
		@role = @workplace.roles.new
	end

	def create
		@role = @workplace.roles.new params[:role]
		if @role.save
			redirect_to workplace_roles_path, notice: "Role created successfully"
		else
			render :new, error: @role.errors.full_messages
		end
	end

	def edit
		@role = @workplace.roles.find params[:id]
	end

	def update
		@role = @workplace.roles.find params[:id]
		if @role.update_attributes params[:role]
			redirect_to workplace_roles_path, notice: "Role update successfully"
		else
			render :edit, error: @role.errors.full_messages
		end
	end

	def destroy
		@role = @workplace.roles.find params[:id]
		if @role.destroy
			redirect_to workplace_roles_path, notice: "Role deleted successfully"
		else
			redirect_to workplace_roles_path, error: @role.errors.full_messages
		end		
	end
end