class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

  def after_sign_in_path_for(resource)
  	workplace_shifts_path(Workplace.last)
  end

  def set_workplace
  	@workplace = Workplace.find params[:workplace_id]
  end
end
