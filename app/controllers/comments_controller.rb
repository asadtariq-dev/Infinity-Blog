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

  def destroy
    @comment = current_author.comments.find(params[:id])
    authorize @comment
    if @comment.destroy
      redirect_back(fallback_location: posts_url)
      flash[:alert] = 'Comment has been Deleted'
    else
      flash[:alert] = @comment.errors.full_messages.to_sentence
    end
  end

  private

  def comment_params
    params.permit(:content, :image, :parent_id).merge(post_id: params[:post_id])
  end
end
