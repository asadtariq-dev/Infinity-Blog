# frozen_string_literal: true

class SuggestionsController < ApplicationController
  before_action :set_suggestion, :authorize_suggestion, only: %i[update edit destroy]

  def index
    @suggestions = current_author.suggestions.all.order(id: :desc)
  end

  def update
    if @suggestion.update(suggestion_params)
      redirect_to post_path(@suggestion.post), notice: t('suggestion_updated')
    else
      render :edit, status: :unprocessable_entity, alert: @suggestion.errors.full_messages.to_sentence
    end
  end

  def create
    @suggestion = current_author.suggestions.new(suggestion_params)

    flash[:notice] = if @suggestion.save
                       t('suggestion_posted')
                     else
                       @suggestion.errors.full_messages.to_sentence
                     end
    redirect_to post_path(params[:post_id])
  end

  def destroy
    flash[:alert] = if @suggestion.destroy
                      t('suggestion_rejected')
                    else
                      @suggestion.errors.full_messages.to_sentence
                    end
    redirect_to post_path(params[:post_id])
  end

  private

  def set_suggestion
    @suggestion = Suggestion.find(params[:id])
  end

  def authorize_suggestion
    authorize @suggestion
  end

  def suggestion_params
    params.require(:suggestion).permit(:content, :parent_id).merge(post_id: params[:post_id])
  end
end
