# frozen_string_literal: true

class PostSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :title, :description, :status, :content, :header_image, :published_at
  belongs_to :author

  def header_image
    object.header_image.url
  end
end
