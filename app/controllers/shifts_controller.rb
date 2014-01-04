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
		
	end

	def edit
		
	end

	def update
		
	end

	def destroy
		
	end
end