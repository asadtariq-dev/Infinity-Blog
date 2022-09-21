# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, :authorize_comment, only: %i[destroy]

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:notice] = t('comment_posted')
    else
      flash[:alert] = @comment.errors.full_messages.to_sentence
    end
    redirect_to post_path(params[:post_id])
  end

  def destroy
    flash[:alert] = if @comment.destroy
                      t('comment_deleted')
                    else
                      @comment.errors.full_messages.to_sentence
                    end
    if current_author.moderator?
      redirect_to root_path
    else
      redirect_to post_path(params[:post_id])
    end
  end

  private

  def comment_params
    params.permit(:author_id, :content, :image, :parent_id).merge(post_id: params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def authorize_comment
    authorize @comment
  end
end
