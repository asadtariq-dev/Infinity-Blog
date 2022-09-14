# frozen_string_literal: true

class AuthorsController < ApplicationController
  before_action :check_url, only: %i[show]
  before_action :authorize_author, only: %i[show destroy]

  def show
    @posts = current_author.posts.order(id: :desc)
  end

  def destroy
    redirect_to new_session_path, notice: 'Account Deleted' if current_author.destroy
  end

  private

  def authorize_author
    authorize current_author
  end

  def check_url
    return if current_author.id.to_s == params[:id]

    redirect_to author_profile_path(current_author)
  end
end
