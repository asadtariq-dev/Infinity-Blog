# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @comment = current_author.comments.new(comment_params)
    if @comment.save
      flash[:notice] = 'Comment successfully posted'
    else
      flash[:alert] = @comment.errors.full_messages.to_sentence
    end
    redirect_back(fallback_location: posts_url)
  end

  private

  def comment_params
    params.permit(:content, :image, :parent_id).merge(post_id: params[:post_id])
  end
end
