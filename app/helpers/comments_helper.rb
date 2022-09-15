# frozen_string_literal: true

module CommentsHelper
  def image_attached?(comment)
    comment.image.attached?
  end

  def comments?(comments)
    comments.any?
  end
end
