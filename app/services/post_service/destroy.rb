module PostService::Destroy
  extend self

  def call(post)
    SolidQueue::Job.find_by(active_job_id: post.job_id).discard

    [post.destroy, post]
  end
end
