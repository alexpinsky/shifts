class UsersController < ApplicationController
	before_filter :set_workplace

	def index
		@users = @workplace.users.includes(:roles).where("roles.workplace_id = ?", @workplace.id).references(:roles)
	end

	def new
		@user = @workplace.users.new
		@roles = @workplace.roles
	end

	def create
		role_ids = params[:user][:role_ids].select { |id| id.present? }
		result = User.create_with_roles(user_params: user_params, role_ids: role_ids, workplace: @workplace)
		if result[:success]
			flash[:success] = "User created successfully"
			redirect_to workplace_users_path(@workplace)
		else
			@user = result[:user] || @workplace.users.new
			@roles = @workplace.roles
			flash[:error] = result[:msg]
			render :new
		end
	end

	def edit
		@user = @workplace.users.find params[:id]
		@roles =@workplace.roles
	end

	def update
		@user = @workplace.users.find params[:id]		
		role_ids = params[:user][:role_ids].select { |id| id.present? }
		result = User.update_with_roles(user: @user, user_params: user_params, role_ids: role_ids, workplace: @workplace)
		if result[:success]
			flash[:success] = "User updated successfully"
			redirect_to workplace_users_path(@workplace)
		else
			@user = result[:user]
			@roles = @workplace.roles
			flash[:error] = result[:msg]
			render :news
		end
	end

	def destroy
		
	end

private

	def user_params
		params.require(:user).permit(:first_name, :last_name, :email)
	end
end