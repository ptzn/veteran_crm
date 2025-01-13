module PostService::Schedule
  extend self

  def call(post, reschedule: false)
    return [false, post.scheduled_at] if post.scheduled_at.blank? || post.scheduled_at.past? || post.draft?

    if reschedule && (job = SolidQueue::Job.find_by(active_job_id: post.job_id))
      job.discard
    end

    job = PublishPostJob.
            set(wait_until: post.scheduled_at).
            perform_later(post)

    post.update(job_id: job.job_id)

    [!!job, post]
  end
end
