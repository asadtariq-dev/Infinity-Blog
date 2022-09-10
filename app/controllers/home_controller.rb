# frozen_string_literal: true

  class HomeController < ApplicationController
    def index
      @posts = Post.published.most_recent_posts
      @comments = Comment.order(id: :desc).limit(5)
    end
  end
