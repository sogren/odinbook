class LikesController < ApplicationController
	respond_to :html, :js

	def create
		@like = current_user.likes_relations.build(likeable_id: params[:likeable_id], likeable_type: params[:likeable_type])
		if @like.save
			flash[:info] = "successfully liked"
		else
			flash[:info] = "something went wrong"
		end
		render nothing: true
	end
end
