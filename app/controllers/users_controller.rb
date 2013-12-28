class UsersController < ApplicationController
	before_filter :set_work_place

	def index
		@users = @work_place.users.includes(:roles).where("roles.work_place_id = ?", @work_place.id)
	end

	def new
		@user = @work_place.users.new
		@roles = @work_place.roles
	end

	def create
		role_ids = params[:user][:role_ids].select { |id| id.present? }
		result = User.create_with_roles(user_params: params[:user].except(:role_ids), role_ids: role_ids, work_place: @work_place)
		if result[:success]
			flash[:success] = "User created successfully"
			redirect_to work_place_users_path(@work_place)
		else
			@user = result[:user]
			@roles = @work_place.roles
			flash[:error] = result[:msg]
			render :new
		end
	end
end