# frozen_string_literal: true

module Authors
  class SuggestionsController < AuthorsController
    # before_action :set_suggestion, only: %i[destroy]

    def index
      @suggestions = current_author.suggestions.all.order(id: :desc)
    end

    def create
      @suggestion = current_author.suggestions.new(suggestion_params)

      if @suggestion.save
        redirect_to blog_post_path(params[:post_id]), notice:  'Suggestion successfully posted'
      else
        redirect_to blog_post_path(params[:post_id]), notice:  @suggestion.errors.full_messages.to_sentence
      end
    end

    def destroy
      puts "Suggestionnnnnnnnnnnnnnnn\n\n\n\n\n\n\n\n\n\n\n\n"
      @suggestion = Suggestion.find(params[:id])
      @suggestion.destroy
      redirect_to root_path, status: :see_other
      # end
      # binding.pry
      # if @suggestion.destroy
      #   redirect_to post_path(params[:post_id]), notice: 'Suggestion rejected successfully'
      # else
      #   redirect_to post_path(params[:post_id]), notice: @post.errors.full_messages.to_sentence
      # end
    end

    private

    def set_suggestion
      @suggestion = Suggestion.find(params[:id])
    end

    def suggestion_params
      params.require(:suggestion).permit(:content, :parent_id).merge(post_id: params[:post_id])
    end
  end
end
