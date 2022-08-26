module Authors
  class PostsController < AuthorsController
    before_action :set_post, only: %i[show edit update destroy publish]

    # GET /posts or /posts.json
    def index
      @posts = current_author.posts
    end

    def show
      @post = current_author.posts.find(params[:id])
    end

    # GET /posts/new
    def new
      @post = current_author.posts.build
    end

    # GET /posts/1/edit
    def edit; end

    # POST /posts or /posts.json
    def create
      @post = current_author.posts.build(post_params)
      redirect_to edit_post_path(@post) if @post.save
    end

    # PATCH/PUT /posts/1 or /posts/1.json
    def update
      redirect_to edit_post_path(@post) if @post.update(post_params)
    end

    def publish
      @post = current_author.posts.find(params[:id])
      if @post.published?
        @post.update_attribute(:published, false)
        @post.update_attribute(:published_at, nil)
      else
        @post.update_attribute(:published, true)
        @post.update_attribute(:published_at, Time.now)
      end
      redirect_to edit_post_path(@post)
    end

    # DELETE /posts/1 or /posts/1.json
    def destroy
      redirect_to posts_path if @post.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = current_author.posts.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :description, :content, :header_image, :published, :published_at)
    end
  end
end

