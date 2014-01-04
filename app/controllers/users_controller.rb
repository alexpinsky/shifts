class UsersController < ApplicationController
	before_filter :set_workplace

	def index
		@users = @workplace.users.includes(:roles).where("roles.workplace_id = ?", @workplace.id)
	end

	def new
		@user = @workplace.users.new
		@roles = @workplace.roles
	end

	def create
		role_ids = params[:user][:role_ids].select { |id| id.present? }
		result = User.create_with_roles(user_params: params[:user].except(:role_ids), role_ids: role_ids, workplace: @workplace)
		if result[:success]
			flash[:success] = "User created successfully"
			redirect_to workplace_users_path(@workplace)
		else
			@user = result[:user]
			@roles = @workplace.roles
			flash[:error] = result[:msg]
			render :new
		end
	end
end