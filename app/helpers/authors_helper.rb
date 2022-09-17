# frozen_string_literal: true

module AuthorsHelper
  def current_author_has_posts
    current_author.posts.present?
  end
end
