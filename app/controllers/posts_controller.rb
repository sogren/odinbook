class PostsController < ApplicationController
	before_action :set_post, only: [:show, :edit, :update, :destroy]
	before_action :authorize, only: [:show]
	skip_before_filter :require_login, only: [:show]
	def index
		@posts = Post.all
	end

	def show
		@post = Post.find(params[:id])
	end

	def new
		@post = Post.new
	end

	def edit
	end

	def create
		@post = current_user.posts.build(post_params)
		respond_to do |format|
			if @post.save
				format.html { redirect_to :back, notice: 'Post was successfully created.' }
				format.json { render :show, status: :created, location: @post }
			else
				format.html { redirect_to :back, notice: 'Post creation failed.'  }
				format.json { render json: @post.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @post.update(post_params)
				format.html { redirect_to root_path, notice: 'Post was successfully updated.' }
				format.json { render :show, status: :ok, location: @post }
			else
				format.html { render :edit }
				format.json { render json: @post.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@post.destroy
		respond_to do |format|
			format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_post
			@post = Post.find(params[:id])
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def post_params
			params.require(:post).permit(:content,:receiver_id)
		end
end
