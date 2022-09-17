# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    @like = Like.new(like_params)
    redirect_back(fallback_location: root_path) if @like.save
  end

  def destroy
    @like = Like.find(params[:id])
    redirect_back(fallback_location: root_path) if @like.destroy
  end

  private

  def like_params
    params.permit(:author_id, :likeable_id, :likeable_type)
  end
end
