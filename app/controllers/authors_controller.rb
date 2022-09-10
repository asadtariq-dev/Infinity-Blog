# frozen_string_literal: true

class AuthorsController < ApplicationController
  before_action :authenticate_author!

  def show
    @posts = current_author.posts.order(id: :desc)
  end
end
