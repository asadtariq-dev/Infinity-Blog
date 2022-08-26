module Readers
  class HomeController < ReadersController
    def index
      @posts = Post.published.most_recent_posts
    end
  end
end
