class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.author = current_user

    if @comment.save
      redirect_to user_post_path(@post.author, @post), notice: 'Comment created successfully.'
    else
      redirect_to user_post_path(@post.author, @post), alert: 'Failed to create comment.'
    end
  end

  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end