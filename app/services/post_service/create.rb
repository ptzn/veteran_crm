module PostService::Create
  extend self

  def call(post_params)
    post = Post.create(post_params)

    PostService::Schedule.call(post) if post.persisted?

    [post.persisted?, post]
  end
end
