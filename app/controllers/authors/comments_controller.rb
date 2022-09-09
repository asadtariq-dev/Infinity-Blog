# frozen_string_literal: true

module Authors
  class CommentsController < AuthorsController
    def create
      @comment = current_author.comments.new(comment_params)
      flash[:notice] = if @comment.save
                         'Comment successfully posted'
                       else
                         @comment.errors.full_messages.to_sentence
                       end
      redirect_back(fallback_location: posts_url)
    end

    private

    def comment_params
      params.require(:comment).permit(:content, :parent_id).merge(post_id: params[:post_id])
    end
  end
end
