# frozen_string_literal: true

class SuggestionsController < ApplicationController
  before_action :set_suggestion, :authorize_suggestion, only: %i[update edit destroy]

  def index
    @suggestions = current_author.suggestions.all.order(id: :desc)
  end

  def update
    respond_to do |format|
      if @suggestion.update(suggestion_params)
        format.html { redirect_to post_path(@suggestion.post), notice: t('suggestion_updated') }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def create
    @suggestion = current_author.suggestions.new(suggestion_params)
    redirect_to post_path(params[:post_id]), notice: t('suggestion_created') if @suggestion.save
  end

  def destroy
    redirect_to post_path(params[:post_id]), alert: t('suggestion_rejected') if @suggestion.destroy
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
