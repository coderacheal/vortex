class PostsController < ApplicationController
  before_action :set_current_user

  def index
    @user = User.find(params[:user_id])
    @user_posts = Post.includes(:comments).where(author_id: @user.id)
    @recent_comments = @user_posts.map(&:recent_comments).flatten
  end

  def show
    @post = Post.find(params[:id])
    @post_comments = Comment.where(post_id: @post)
  end

  def new; end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to user_posts_path(current_user), notice: 'Post created successfully.'
    else
      render :new, notice: 'Post could not be created.'
    end
  end

  private

  # Whitelist and extract the allowed parameters
  def post_params
    params.require(:post).permit(:title, :text)
  end

  def set_current_user
    @current_user = current_user
  end
end
