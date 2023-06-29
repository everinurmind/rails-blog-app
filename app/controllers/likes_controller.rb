class LikesController < ApplicationController
    def create
      @post = Post.find(params[:post_id])
      @like = @post.likes.build
      @like.author = current_user
      @like.user_id = current_user.id
  
      if @like.save
        redirect_to user_post_path(@post.author, @post), notice: 'Like added successfully.'
      else
        redirect_to user_post_path(@post.author, @post), alert: 'Failed to add like.'
      end
    end
  end
  