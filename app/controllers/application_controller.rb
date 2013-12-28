class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

  def after_sign_in_path_for(resource)
  	choose_flow_path
  end

  def set_work_place
  	@work_place = WorkPlace.find params[:work_place_id]
  end
end
