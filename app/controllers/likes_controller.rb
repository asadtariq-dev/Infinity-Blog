# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    @like = current_author.likes.new(like_params)
    flash[:notice] = @like.errors.full_messages.to_sentence unless @like.save
  end

  def destroy
    @like = current_author.likes.find(params[:id])
    @like.destroy
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end
