class PostsController < ApplicationController
    before_action :set_current_user

  # def index
  #   # @user = User.find(params[:user_id])
  #   # @post = Post.find(params[:id])
  #   @user_posts = Post.includes(:comments).where(author_id: @user.id)
  #   @recent_comments = @post.recent_comments
  # end

  def index
    @user = User.find(params[:user_id])  # Uncomment this line
    @user_posts = Post.includes(:comments).where(author_id: @user.id)
    @recent_comments = @user_posts.map { |post| post.recent_comments }.flatten
    # @recent_comments = @user_posts.recent_comments
  end
  

  def show
    @post = Post.find(params[:id])
    # @post_comments = @post.recent_comments
    @post_comments = Comment.where(post_id: @post)
  end

  def new
  end

#   def create
#     # create a new post associated to the current_user
#     @post = current_user.posts.create(post_params)
#     @post.author = current_user

#     if @post.save
#       # if post saved, redirect to the user's posts and render success message
#       redirect_to user_posts_path(current_user), notice: 'Post created successfully.'
#     else
#       # if post not saved, render new template and render error message
#       render :new, notice: 'Post could not be created.'
#     end
#   end

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
