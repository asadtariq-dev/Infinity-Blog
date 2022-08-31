module Authors
  class SuggestionsController < AuthorsController
    def create
      @suggestion = current_author.suggestions.new(suggestion_params)
      flash[:notice] = @suggestion.errors.full_messages.to_sentence unless @suggestion.save

      redirect_to blog_post_path(params[:post_id])
    end

    private

    def suggestion_params
      params.require(:suggestion).permit(:content, :parent_id).merge(post_id: params[:post_id])
    end
  end
end
