# frozen_string_literal: true

class ModeratorsController < ApplicationController
  before_action :authorize_user, only: %i[index show]
  before_action :set_post, only: %i[show destroy publish_post]

  def index
    @pending_posts = Post.pending.order(created_at: :desc)
    @reported_posts = Post.all_reported.order(id: :desc)
    @reported_comments = Comment.all_reported.order(id: :desc)
  end

  def show; end

  def destroy
    if @post.destroy
      redirect_to root_path, alert: t('post_deleted')
    else
      flash[:alert] = @post.errors.full_messages.to_sentence
    end
  end

  def publish_post
    if @post.published?
      @post.unpublished!
      helpers.delete_post_reports(@post.id)
      redirect_to moderators_path, notice: t('post_unpublished')
    else
      @post.published!
      @post.update(published_at: Time.zone.now)
      redirect_to moderators_path, notice: t('post_published')
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_user
    redirect_to root_path unless current_author.moderator?
  end

  def post_params
    params.require(:post).permit(:published, :published_at)
  end
end
