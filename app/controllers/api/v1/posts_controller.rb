# frozen_string_literal: true

module Api
  module V1
    class PostsController < ApplicationController
      def index
        @posts = Post.all.order(id: :desc)
        render json: @posts, root: false
      end

      def show
        @post = Post.find(params[:id])
        render json: @post, root: false
      end
    end
  end
end
