# frozen_string_literal: true

module PostsHelper
  def published_time(post)
    time_ago_in_words(post.published_at)
  end

  def content?(post)
    post.content.present?
  end

  def posts?(posts)
    posts.present?
  end

  def post_unpublished?(post)
    post.unpublished?
  end
end
