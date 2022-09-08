# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    @like = current_author.likes.new(like_params)

    flash[:notice] = @like.errors.full_messages.to_sentence unless @like.save

    redirect_to @like.post if @like.comment.nil?
    redirect_to @like.comment if @like.post.nil?
  end

  def destroy
    @like = current_author.likes.find(params[:id])

    @like.destroy
    redirect_to @like.post if @like.comment.nil?
    redirect_to @like.comment if @like.post.nil?
  end

  private

  def like_params
    params.require(:like).permit(:post_id, :comment_id)
  end
end
