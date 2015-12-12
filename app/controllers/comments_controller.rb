class CommentsController < ApplicationController
	def new
		@comment = Comment.new
		@id = params[:post]
		@type = params[:commentable_type]
	end

	def create
		@comment = current_user.comments.create(comment_params)
		if @comment.save
			flash[:notice] = "comment added"
			redirect_to root_path
		else
			flash[:notice] = "adding failed"
			redirect_to root_path
		end
	end

	private

		def comment_params
			params.require(:comment).permit(:content, :commentable_id, :commentable_type)
		end
end
