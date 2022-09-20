# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    @like = Like.new(like_params)
    flash[:alert] = @like.errors.full_messsages unless @like.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @like = Like.find(params[:id])
    flash[:alert] = @like.errors.full_messsages unless @like.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def like_params
    params.permit(:author_id, :likeable_id, :likeable_type)
  end
end
