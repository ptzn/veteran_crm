class PublishPostJob < ApplicationJob
  queue_as :default

  def perform(post)
    return if post.published?

    ok, = TelegramService::SendMessage.call(post)

    post.broadcast_remove_to :upcoming_posts if ok
  end
end
