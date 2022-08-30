class AuthorsController < ApplicationController
  before_action :authenticate_author!

  layout 'users/authors'

  def show
    @posts = current_author.posts.order(published_at: :desc)
  end
end
