class LikesController < ApplicationController
  respond_to :html, :js
  expose(:like) { Like.find() }

  def create
    like.liker = current_user
    like.save
    render 'reload.js', locals: likes_locals(like)
  end

  def destroy
    like.liker = current_user
    like.destroy
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
