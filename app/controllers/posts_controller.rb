# frozen_string_literal: true

class PostsController < AuthorsController
  before_action :set_post, only: %i[edit update destroy submit]

  def index
    @posts = current_author.posts.order(id: :desc)
  end

  def show
    if Post.find(params[:id]).published?
      @post = Post.find(params[:id])
    else
      redirect_to root_path, notice: 'Post has been unpublished'
    end
  end

  def new
    @post = current_author.posts.build
  end

  def create
    @post = current_author.posts.build(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to edit_post_path(@post), notice: 'Post was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to edit_post_path(@post), notice: 'Post successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def submit
    if @post.pending?
      @post.unpublished!
      @post.update_attribute(:published_at, nil)
    else
      @post.pending!
    end
    redirect_to edit_post_path(@post)
  end

  def destroy
    if @post.destroy
      redirect_to author_profile_path(current_author), notice: 'Post Deleted Successfully'
    else
      redirect_to post_path(params[:post_id]), notice: @post.errors.full_messages.to_sentence
    end
  end

  private

  def set_post
    @post = current_author.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description, :content, :header_image, :status)
  end
end
