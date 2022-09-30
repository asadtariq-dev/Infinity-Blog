# frozen_string_literal: true

module Api
  module V1
    class PostsController < ApplicationController
      def index
        @posts = Post.all.order(id: :desc)
        @json_posts = @posts.map { |e| e.as_json.merge(header_image: e.header_image.url, content: e.content, author: { first_name: e.author.first_name, last_name: e.author.last_name }) }
        render json: @json_posts
      end
    end
  end
end
