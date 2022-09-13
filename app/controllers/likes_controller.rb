# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    # binding.pry
    @like = current_author.likes.new(like_params)
    flash[:notice] = @like.errors.full_messages.to_sentence unless @like.save
    respond_to :js
  end

  def destroy
    @like = current_author.likes.find(params[:id])
    @like.destroy
    respond_to :js
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end
