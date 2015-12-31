class CommentsController < ApplicationController
	def new
		@comment = Comment.new
		@id = params[:post]
	end

	def create
		@comment = current_user.comments.create(comment_params)
		if @comment.save
			flash[:info] = "comment added"
		else
			flash[:warning] = "adding failed"
		end
		redirect_to :back
	end

	 private

	def comment_params
			params.require(:comment).permit(:content, :post_id)
		end
end
