module PostService::Schedule
  extend self

  def call(post, reschedule: false)
    return [false, post.scheduled_at] if post.scheduled_at.blank? || post.scheduled_at.past?

    if reschedule
      SolidQueue::Job.find_by(active_job_id: post.job_id).discard
    end

    job_id = PublishPostJob.
               set(wait_until: post.scheduled_at).
               perform_later(post)

    post.update(job_id: job_id)

    [!!job_id, post]
  end
end
