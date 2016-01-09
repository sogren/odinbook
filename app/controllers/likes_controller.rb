class LikesController < ApplicationController
	respond_to :html, :js

	def create
		@like_relation = current_user.likes_relations.new(likes_params)
		@like_relation.save
		render 'reload.js', locals: likes_locals(@like_relation)
	end

	def destroy
		@like_relation = current_user.likes_relations.find_by(likes_params)
		@like_relation.destroy
		render 'reload.js', locals: likes_locals(@like_relation)
	end

	private

		def likes_locals(relation)
			@id = likes_params[:likeable_id]
			@type = likes_params[:likeable_type]
			@likes = relation.likes
			{ type: @type, id: @id, likes: @likes }
		end

		def likes_params
			params.require(:liked).permit(:likeable_id, :likeable_type)
		end
end
