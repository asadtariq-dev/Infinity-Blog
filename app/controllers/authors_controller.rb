class AuthorsController < ApplicationController
  before_action :authenticate_author!

  def show
    @posts = current_author.posts.order(published_at: :desc)
  end
end
