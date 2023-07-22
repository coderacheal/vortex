class PostsController < ApplicationController
    def index
      @user = User.find(params[:user_id])
      @user_posts = Post.includes(:comments).where(author_id: @user.id)
      @post_comments = Comment.includes(:author).where(post_id: @user_posts.ids)
    end
  
    def show
      @post = Post.find(params[:id])
      @post_comments = Comment.where(post_id: @post)
    end

end
