# frozen_string_literal: true

module Authors
  class PostsController < AuthorsController
    before_action :set_post, only: %i[show edit update destroy submit]

    # GET /posts or /posts.json
    def index
      @posts = current_author.posts.order(published_at: :desc)
    end

    def show
      @post = current_author.posts.find(params[:id])
    end

    # GET /posts/new
    def new
      @post = current_author.posts.build
    end

    # POST /posts or /posts.json
    def create
      @post = current_author.posts.build(post_params)
      respond_to do |format|
        if @post.save
          format.html { redirect_to edit_post_path(@post), notice: 'Post was successfully created.' }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /posts/1 or /posts/1.json
    def update
      respond_to do |format|
        if @post.update(post_params)
          format.html { redirect_to edit_post_path(@post), notice: 'Post successfully updated.' }
          format.json { render :show, status: :updated, location: @post }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end

    def submit
      @post = current_author.posts.find(params[:id])
      if @post.content.present?
        notice = nil
        if @post.submitted?
          @post.update_attribute(:submitted, false)
          @post.update_attribute(:published, false)
          @post.update_attribute(:pending, false)
          @post.update_attribute(:submitted_at, nil)
        else
          @post.update_attribute(:submitted, true)
          @post.update_attribute(:pending, true)
          @post.update_attribute(:submitted_at, Time.now)
        end
      else
        message = 'Please Add Some Content To Submit'
      end
      redirect_to edit_post_path(@post), alert: message
    end

    # DELETE /posts/1 or /posts/1.json
    def destroy
      if @post.destroy
        redirect_to author_profile_path(current_author), notice: 'Post Deleted Successfully'
      else
        redirect_to post_path(params[:post_id]), notice: @post.errors.full_messages.to_sentence
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = current_author.posts.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :description, :content, :header_image, :submitted, :submitted_at)
    end
  end
end
