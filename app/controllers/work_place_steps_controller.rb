class WorkPlaceStepsController < ApplicationController

  before_filter :set_work_place

  def details
  	
  end

  def roles
  	
  end
  
  private 

  def set_work_place
  	@work_place = params[:work_place_id].blank? ? WorkPlace.new : params[:work_place_id]
  end
end