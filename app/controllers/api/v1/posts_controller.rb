# frozen_string_literal: true

module Api
  module V1
    class PostsController < ApplicationController
      def index
        @posts = Post.all.order(id: :desc)
        @json_posts = @posts.map { |e| e.as_json.merge(header_image: e.header_image.url, content: e.content, author: { first_name: e.author.first_name, last_name: e.author.last_name }) }
        render json: @json_posts
      end

      def show
        @post = Post.find(params[:id])
        @json_post = @post.as_json.merge(header_image: @post.header_image.url, content: @post.content, author: { first_name: @post.author.first_name, last_name: @post.author.last_name })
        render json: @json_post
      end
    end
  end
end
