class PublishPostJob < ApplicationJob
  queue_as :default

  def perform(post)
    return if post.published?

    TelegramService::SendMessage.call(post)
  end
end
