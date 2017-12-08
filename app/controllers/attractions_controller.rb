class AttractionsController < ApplicationController
	def index
		@attractions = Attraction.all
	end

	def new
		@attraction = Attraction.new
	end

	def create
		@attraction = Attraction.new(attraction_params)
		if @attraction.save
			redirect_to attraction_path(@attraction)
		else 
			flash[:notice] = "The attraction couldn't be saved"
			redirect_to attraction_path(@attraction)
		end
	end

	def show
		@attraction = Attraction.find(params[:id])
	end

	def edit
		@attraction = Attraction.find(params[:id])
	end

	def update
		@attraction = Attraction.find(params[:id])
		if attraction_params[:user_id].present?	
			@user = User.find(attraction_params[:user_id])
			@ride = Ride.new(user_id: @user.id, attraction_id: params[:id])
			flash[:notice] = "#{@ride.take_ride}"
			@ride.save!
			redirect_to user_path(@user)
		else
			if @attraction.update_attributes(attraction_params)
				redirect_to attraction_path(@attraction)
			else 
				flash[:notice] = "The attraction couldn't be updated"
				redirect_to attraction_path(@attraction)
			end
		end
	end

	def attraction_params
		params.require(:attraction).permit(:user_id, :name, :tickets, :nausea_rating, :happiness_rating, :min_height)
	end
end
