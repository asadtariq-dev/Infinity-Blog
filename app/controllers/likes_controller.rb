# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    @like = current_author.likes.new(like_params)
    # @post = Post.find(@like.likeable_id)
    respond_to do |format|
      format.js if @like.save
    end
  end

  def destroy
    @like = current_author.likes.find(params[:id])
    if @like.destroy
      respond_to :js
    else
      flash[:alert] = @like.errors.full_messages.to_sentence
    end
  end

  private

  def like_params
    params.permit(:author_id, :likeable_id, :likeable_type)
  end
end
