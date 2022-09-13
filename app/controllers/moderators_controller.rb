# frozen_string_literal: true

class ModeratorsController < ApplicationController
  before_action :set_post, only: %i[show publish_post]
  def index
    @pending_posts = Post.pending.order(created_at: :desc)
    @reported_posts = Post.joins(:reports).distinct.order(id: :desc)
    @reported_comments = Comment.joins(:reports).distinct.order(id: :desc)
  end

  def publish_post
    if @post.published?
      @post.unpublished!
      @post.update_attribute(:published_at, nil)
      Post.delete_reports(@post.id)
      redirect_to moderators_path, notice: 'Post has been unpublished'
    else
      @post.published!
      @post.update_attribute(:published_at, Time.now)
      redirect_to moderators_path, notice: 'Post has been approved'
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:published, :published_at)
  end
end
