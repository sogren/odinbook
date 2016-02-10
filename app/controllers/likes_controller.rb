class LikesController < ApplicationController
  respond_to :js
  expose(:like) { current_user.likes_relations.where(likes_params).first_or_create }

  def create
    render 'reload.js', locals: likes_locals(like)
  end

  def destroy
    like.destroy
    render 'reload.js', locals: likes_locals(like)
  end

  private

  def likes_locals(like)
    @id = like.likeable_id
    @type = like.likeable_type
    @likes = like.likes
    { type: @type, id: @id, likes: @likes, liked: user_liked?(like.likeable) }
  end

  def likes_params
    params.require(:liked).permit(:likeable_id, :likeable_type)
  end
end
