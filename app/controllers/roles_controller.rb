class RolesController < ApplicationController
	before_filter :set_work_place
	
	def index
		@roles = @work_place.roles
	end

	def new
		@role = @work_place.roles.new
	end

	def create
		@role = @work_place.roles.new params[:role]
		if @role.save
			redirect_to work_place_roles_path, notice: "Role created successfully"
		else
			render :new, error: @role.errors.full_messages
		end
	end

	def edit
		@role = @work_place.roles.find params[:id]
	end

	def update
		@role = @work_place.roles.find params[:id]
		if @role.update_attributes params[:role]
			redirect_to work_place_roles_path, notice: "Role update successfully"
		else
			render :edit, error: @role.errors.full_messages
		end
	end

	def destroy
		@role = @work_place.roles.find params[:id]
		if @role.destroy
			redirect_to work_place_roles_path, notice: "Role deleted successfully"
		else
			redirect_to work_place_roles_path, error: @role.errors.full_messages
		end		
	end
end