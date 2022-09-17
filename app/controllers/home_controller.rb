# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authorize_user, only: %i[index]
  def index
    @posts = Post.published.order(published_at: :desc)
    @comments = Comment.not_reply.order(id: :desc).limit(5)
  end

  private

  def authorize_user
    admin_dashboard if current_author.admin?
    moderator_dashboard if current_author.moderator?
  end

  def admin_dashboard
    redirect_to '/admin'
  end

  def moderator_dashboard
    redirect_to moderators_path
  end
end
