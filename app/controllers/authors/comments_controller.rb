module Authors
  class CommentsController < AuthorsController
    def create
      @comment = current_author.comments.new(comment_params)
      flash[:notice] = @comment.errors.full_messages.to_sentence unless @comment.save

      redirect_to blog_post_path(params[:post_id])
    end

    private

    def comment_params
      params.require(:comment).permit(:content, :parent_id).merge(post_id: params[:post_id])
    end
  end
end
