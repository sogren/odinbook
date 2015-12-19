class CommentsController < ApplicationController
	def new
		@comment = Comment.new
		@id = params[:post]
	end

	def create
		@comment = current_user.comments.create(comment_params)
		if @comment.save
			flash[:info] = "comment added"
			redirect_to root_path
		else
			flash[:warning] = "adding failed"
			redirect_to root_path
		end
	end

	private

		def comment_params
			params.require(:comment).permit(:content, :post_id)
		end
end
