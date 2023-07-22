class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @user_posts = Post.includes(:comments).where(author_id: @user.id)
  end

  def show
    @post = Post.find(params[:id])
  end
end
