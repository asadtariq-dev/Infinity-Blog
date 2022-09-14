# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    if current_author.admin?
      admin_dashboard
    elsif current_author.moderator?
      moderator_dashboard
    else
      @posts = Post.published.order(published_at: :desc)
      @comments = Comment.order(id: :desc).limit(5)
    end
  end

  private

  def admin_dashboard
    redirect_to '/admin'
  end

  def moderator_dashboard
    # load data required for operators
    redirect_to moderators_path
  end
end
