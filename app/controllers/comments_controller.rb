class CommentsController < ApplicationController
  expose(:comment)

  def more_comments
    @post = Post.find_by(id: params[:post_id])
    @page = params[:comment_page]
    @comments = @post.comments.paginate(page: @page)
    @page = (@page.to_i + 1).to_s
    respond_to do |format|
      format.html { render nothing: true }
      format.js   { render partial: "shared/pagination" }
    end
  end

  def new
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
