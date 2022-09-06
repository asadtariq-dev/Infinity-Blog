module Readers
  class HomeController < ReadersController
    def index
      @posts = Post.published.most_recent_posts
      @comments = Comment.order(id: :desc).limit(5)
    end
  end
end
