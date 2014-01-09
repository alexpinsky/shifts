class ShiftsController < ApplicationController
	before_filter :set_workplace

	def index
		if @workplace
			# @shifts = @workplace.roles.shifts
			
		else
			
		end
	end

	def new
		@shift = @workplace.shifts.new(role_id: params[:role_id], start_time: params[:start_time], end_time: params[:end_time])
		@container_id = params[:container_id]
	end

	def create
		assigned_user_ids = params[:shift][:assigned_user_ids].select { |id| id.present? }
		result = Shift.create_with_users(shift_params: params[:shift].except(:assigned_user_ids), assigned_user_ids: assigned_user_ids, workplace: @workplace)
		if result[:success]
			flash[:success] = "shift created successfully"
		else
			flash[:error] = result[:msg]
		end
		redirect_to workplace_shifts_path(@workplace)
	end

	def edit
		
	end

	def update
		
	end

	def destroy
		
	end
end