class LikesController < ApplicationController
  before_action :authenticate_user!
  def index
    @post = Post.find(params[:post_id])
    @likes = @post.likes
    render json: @likes
  end
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(author: current_user)
    if @like.save
      render json: @like, status: :created
    else
      render json: { error: 'Failed to add like.' }, status: :unprocessable_entity
    end
  end
end