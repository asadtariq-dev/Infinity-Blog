# frozen_string_literal: true

module LikesHelper
  def current_like(likeable)
    current_author.likes.find_by(likeable: likeable)
  end

  def likes_count(likeable)
    likeable.likes.count
  end

  def reply_count(comment)
    comment.comments.count
  end
end
