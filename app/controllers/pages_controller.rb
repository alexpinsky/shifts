class PagesController < ApplicationController
	skip_before_filter :authenticate_user!, only: [:home, :wedding]

 	def home
 	end

 	def choose_flow
 	end

 	def wedding
 		render layout: "weddings"
 	end
end