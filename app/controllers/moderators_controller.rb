class ModeratorsController < ApplicationController
  def index
    @unapproved_posts = Post.pending.order(created_at: :desc)
    @reported_posts = Post.joins(:reports).distinct.order(id: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def publish
    @post = Post.find(params[:id])
    if @post.published?
      @post.update_attribute(:published, false)
      @post.update_attribute(:published_at, nil)
      Post.delete_reports(@post.id)
      @post.update_attribute(:submitted, false)
    else
      @post.update_attribute(:published, true)
      @post.update_attribute(:pending, false)

      @post.update_attribute(:published_at, Time.now)
    end
    redirect_to moderators_path
  end

  private

  def post_params
    params.require(:post).permit(:published, :published_at)
  end
end
