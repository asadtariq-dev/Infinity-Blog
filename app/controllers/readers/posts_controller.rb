module Readers
  class PostsController < ReadersController
    def show
      if Post.find(params[:id]).published?
        @post = Post.find(params[:id])
      else
        redirect_to root_path, notice: 'Post has been unpublished'
      end
    end
  end
end
