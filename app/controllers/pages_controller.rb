class PagesController < ApplicationController
	skip_before_filter :authenticate_user!, only: [:home]

 	def home
 	end

 	def choose_flow
 		
 	end
end