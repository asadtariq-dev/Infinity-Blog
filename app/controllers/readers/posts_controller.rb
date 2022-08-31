module Readers
  class PostsController < ReadersController
    def show
      @post = Post.find(params[:id])
      if @post.published?
        @post = Post.find(params[:id])
      else
        redirect_to root_path, notice: 'Post has been unpublished'
      end
    end
  end
end
