class DashboardsController < ApplicationController
  def show
  end

  def upcoming_posts
    @posts = Post.upcoming.limit(10)
  end
end
