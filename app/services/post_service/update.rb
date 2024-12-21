module PostService::Update
  extend self

  def call(post, params)
    return [false, "Cannot change published post"] if post.published?

    post.attributes = params

    reschedule_required = post.scheduled_at_changed?

    ok = post.save

    PostService::Schedule.call(post, reschedule: true) if reschedule_required

    [ok, post]
  end
end
