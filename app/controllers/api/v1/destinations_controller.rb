class Api::V1::DestinationsController < ApplicationController
	before_action :set_destination, only: [:show, :update, :destroy]

	def index
		@destinations = Destination.all
		render json: @destinations, status: :ok 
	end

	def show
		render json: @destination.to_json(include: :tag) if stale?(@destination.to_json(include: :tag))
	end

	def create
		@destination = Destination.new(destination_params)

		if @destination.save
			render json: @destination, status: :created
		else
			render json: @destination.errors, status: :unprocessable_entity
		end
	end

	def update
		if @destination.update(destination_params)
			#byebug
			head :no_content
		else
			render json: @destination.errors, status: :unprocessable_entity
		end
	end

	def destroy
		@destination.destroy

		head :no_content
	end

	private
	def set_destination
		@destination = Destination.find(params[:id])
	end

	def destination_params
		#byebug
		params.require(:destination).permit(:name, :image, :description, :tag_id)
	end
end
