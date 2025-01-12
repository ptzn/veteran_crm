module PostService::Destroy
  extend self

  def call(post)
    if post.job_id && (job = SolidQueue::Job.find_by(active_job_id: post.job_id))
      job.discard
    end

    [post.destroy, post]
  end
end
