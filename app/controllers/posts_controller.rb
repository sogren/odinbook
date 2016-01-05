class PostsController < ApplicationController
	before_action :authorize, only: [:show]
	skip_before_filter :require_login, only: [:show]
 	add_flash_types :danger, :info

	expose(:post)

	def index
		@posts = Post.all
	end

	def show
	end

	def create
		post = current_user.posts.build(post_params)
		respond_to do |format|
			if post.save
				format.html { redirect_to :back, info: 'Post was successfully created.' }
				format.json { render :show, status: :created, location: post }
			else
				format.html { redirect_to :back, danger: 'Post creation failed.' }
				format.json { render json: post.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if post.update(post_params)
				format.html { redirect_to root_path, info: 'Post was successfully updated.' }
				format.json { render :show, status: :ok, location: post }
			else
				format.html { render :edit }
				format.json { render json: post.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		post.destroy
		respond_to do |format|
			format.html { redirect_to posts_url, info: 'Post was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	 private

	def post_params
			params.require(:post).permit(:content, :receiver_id)
		end
end
