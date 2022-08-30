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

    # GET /posts/1/edit
    def edit; end

    # POST /posts or /posts.json
    def create
      @post = current_author.posts.build(post_params)
      if @post.save
        redirect_to edit_post_path(@post)
      else
        redirect_to new_post_path, notice: "#{@post.errors.full_messages}"
      end
    end

    # PATCH/PUT /posts/1 or /posts/1.json
    def update
      redirect_to edit_post_path(@post) if @post.update(post_params)
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
        notice = 'Please Add Some Content To Submit'
      end
      redirect_to edit_post_path(@post), notice: notice
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
      params.require(:post).permit(:title, :description, :content, :header_image, :submitted, :submitted_at)
    end
  end
end
