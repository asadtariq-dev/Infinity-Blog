# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, :authorize_comment, only: %i[destroy]

  def create
    @comment = current_author.comments.new(comment_params)
    if @comment.save
      redirect_to post_path(params[:post_id]), notice: t('comment_posted')
    else
      redirect_to post_path(params[:post_id]), alert: @comment.errors.full_messages.to_sentence
    end
  end

  def destroy
    if @comment.destroy
      redirect_to post_path(params[:post_id]), alert: t('comment_deleted')
    else
      redirect_to post_path(params[:post_id]), alert: @comment.errors.full_messages.to_sentence
    end
  end

  private

  def comment_params
    params.permit(:content, :image, :parent_id).merge(post_id: params[:post_id])
  end

  def set_comment
    @comment = current_author.comments.find(params[:id])
  end

  def authorize_comment
    authorize @comment
  end
end
