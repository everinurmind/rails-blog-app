require_relative '../models/user'
require_relative '../models/post'

class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.includes(posts: [:comments]).find(params[:user_id])
    @posts = @user.posts

    render json: @posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.build
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.build(post_params)

    if @post.save
      redirect_to user_post_path(@user, @post), notice: 'Post created successfully.'
    else
      render :new, alert: 'Failed to create post.'
    end
  end

  def destroy
    @post.destroy
    redirect_to user_posts_path(@user), notice: 'Post successfully deleted.'
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
