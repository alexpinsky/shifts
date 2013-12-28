class ShiftsController < ApplicationController
	before_filter :set_work_place

	def index
		if @work_place
			# @shifts = @work_place.roles.shifts
			
		else
			
		end
	end

	def new
		@shift = @work_place.shifts.new(role_id: params[:role_id])
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