class CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments

    render json: @comments
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.author = current_user

    if @comment.save
      render json: @comment, status: :created
    else
      render json: { error: 'Failed to create comment.' }, status: :unprocessable_entity
    end
  end

  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build
  end

  def destroy
    @comment.destroy
    redirect_to user_post_path(@post.author, @post), notice: 'Comment successfully deleted.'
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
