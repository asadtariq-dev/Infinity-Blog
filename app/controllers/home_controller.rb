# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @posts = Post.published.order(published_at: :desc)
    @comments = Comment.order(id: :desc).limit(5)
  end
end
