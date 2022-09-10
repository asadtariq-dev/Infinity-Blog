# frozen_string_literal: true

class ModeratorsController < ApplicationController
  before_action :set_post, only: %i[show publish]
  def index
    @pending_posts = Post.pending.order(created_at: :desc)
    @reported_posts = Post.joins(:reports).distinct.order(id: :desc)
    @reported_comments = Comment.joins(:reports).distinct.order(id: :desc)
  end

  def publish
    if @post.published?
      @post.unpublished!
      @post.update_attribute(:published_at, nil)
      Post.delete_reports(@post.id)
    else
      @post.published!
      @post.update_attribute(:published_at, Time.now)
    end
    redirect_to moderators_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:published, :published_at)
  end
end
