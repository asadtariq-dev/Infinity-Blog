class ModeratorsController < ApplicationController
  def index
    @unapproved_posts = Post.where(pending: true).order(created_at: :desc)
    @approved_posts = Post.where(published: true).order(id: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def publish
    @post = Post.find(params[:id])
    if @post.published?
      @post.update_attribute(:published, false)
      @post.update_attribute(:published_at, nil)
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
