class PlanesController < ApplicationController
	def index
		@planes = Plane.all
	end

	def new
	end

	def create
		plane = params.require(:planes).permit(:name, :kind, :description)
		Plane.create(plane)
		redirect_to "/planes"
	end

	def show
		id = params[:id] # get the ID passed in the URL
		@plane = Plane.find(id) # Get the correct plane from the database
	end
end