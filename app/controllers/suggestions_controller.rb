# frozen_string_literal: true

class SuggestionsController < ApplicationController
  before_action :set_suggestion, :authorize_suggestion, only: %i[update edit destroy]

  def index
    @suggestions = current_author.suggestions.all.order(id: :desc)
    authorize @suggestions
  end

  def update
    respond_to do |format|
      if @suggestion.update(suggestion_params)
        format.html { redirect_to post_path(@suggestion.post), notice: 'Suggestion successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def create
    @suggestion = current_author.suggestions.new(suggestion_params)
    if @suggestion.save
      redirect_to post_path(params[:post_id]), notice:  'Suggestion successfully posted'
    else
      redirect_to post_path(params[:post_id]), notice:  @suggestion.errors.full_messages.to_sentence
    end
  end

  def destroy
    redirect_to post_path(params[:post_id]), alert: 'Suggestion rejected and deleted' if @suggestion.destroy
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
