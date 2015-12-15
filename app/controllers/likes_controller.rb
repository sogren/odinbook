class LikesController < ApplicationController
	respond_to :html, :js

	def create
		@like = current_user.likes_relations.build(likeable_id: params[:likeable_id], likeable_type: params[:likeable_type])
		if @like.save
			flash[:notice] = "successfully liked"
			redirect_to root_path
		else
			flash[:notice] = "something went wrong"
			redirect_to root_path
		end
	end
end
