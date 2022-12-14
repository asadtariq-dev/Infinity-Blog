# frozen_string_literal: true

class AuthorsController < ApplicationController
  before_action :check_url, only: %i[show]
  before_action :authorize_user, only: %i[show]
  before_action :authorize_author, only: %i[show]

  def show
    @posts = current_author.posts.order(id: :desc)
  end

  private

  def authorize_author
    authorize current_author
  end

  def authorize_user
    redirect_to root_path unless current_author.author?
  end

  def check_url
    return if current_author.id.to_s == params[:id]

    redirect_to author_profile_path(current_author), alert: t('own_profile_only')
  end
end
