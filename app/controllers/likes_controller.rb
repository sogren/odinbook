class LikesController < ApplicationController
	respond_to :html, :js

	def create
		@id = params[:likeable_id]
		@type = params[:likeable_type]
		@like_relation = current_user.likes_relations.build(likeable_id: @id, likeable_type: @type)
		@likeable = @like_relation.likeable
		if @like_relation.save
			flash[:info] = "successfully liked"
		else
			flash[:danger] = "something went wrong"
		end
		render 'reload.js', locals: { type: @type, id: @id, likes: @likeable.likes.length }
	end

	def destroy
		@id = params[:likeable_id]
		@type = params[:likeable_type]
		@like_relation = current_user.likes_relations.find_by(likeable_id: @id, likeable_type: @type)
		@likeable = @like_relation.likeable
		if @like_relation.destroy
			flash[:info] = "successfully unliked"
		else
			flash[:danger] = "something went wrong"
		end
		render 'reload.js', locals: { type: @type, id: @id, likes: @likeable.likes.length }
	end
end
