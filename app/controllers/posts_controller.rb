# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, :authorize_post, only: %i[update destroy submit]

  def index
    @posts = current_author.posts.order(id: :desc)
    redirect_to root_path
  end

  def show
    if Post.find(params[:id]).published?
      @post = Post.find(params[:id])
    else
      redirect_to root_path, notice: t('post_unpublished')
    end
  end

  def new
    @post = current_author.posts.build
  end

  def create
    @post = current_author.posts.new(post_params)
    if @post.save
      redirect_to edit_post_path(@post), notice: t('post_created')
    else
      render :new
    end
  end

  def edit
    @post = current_author.posts.find(params[:id])
  end

  def update
    if @post.update(post_params)
      redirect_to edit_post_path(@post), notice: t('post_updated')
    else
      render :edit
      flash.now[:alert] = t('invalid_values')
    end
  end

  def submit
    if @post.pending?
      @post.unpublished!
      @post.update(published_at: nil)
      flash[:alert] = t('submission_cancelled')
    else
      @post.pending!
      flash[:notice] = t('post_submitted')
    end
    redirect_to edit_post_path(@post)
  end

  def destroy
    redirect_to author_profile_path(current_author), alert: t('post_deleted') if @post.destroy
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_post
    authorize @post
  end

  def post_params
    params.require(:post).permit(:title, :description, :content, :header_image, :status)
  end
end
