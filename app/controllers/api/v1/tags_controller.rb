class Api::V1::TagsController < ApplicationController
	before_action :set_tag, only: [:show, :update, :destroy]
	
	def index
		#byebug
		@tags = Tag.all
		render json: @tags.to_json(include: :destinations), status: :ok
	end

	def show
		#byebug
		@test = @tag
		render json: @tag.to_json(include: :destinations) if stale?(@tag.to_json(include: :destinations))
	end

	def create
		#byebug
		@tag = Tag.new(tag_params)

		if @tag.save
			render json: @tag, status: :created
		else
			render json: @tag.errors, status: :unprocessable_entity
		end
	end

	def update
		#byebug
		if @tag.update(tag_params)
			head :no_content
		else
			render json: @tag.errors, status: :unprocessable_entity
		end
	end

	def destroy
		@tag.destroy

		head :no_content
	end

	private
	def set_tag
		@tag = Tag.find(params[:id])
	end

	def tag_params
		#byebug
		params.require(:tag).permit(:title, :image)
	end
end
