class TelegramService::SendMessage < BaseService
  def initialize(post)
    @post = post
    @chat_id = Config[:telegram][:channel_id]
    @bot = Telegram.bot
  end

  def call
    result = if @post.media.attached?
      @post.media.open do |file|
        @bot.send_photo(chat_id: @chat_id, photo: file, caption: @post.body)
      end
    else
      @bot.send_message(chat_id: @chat_id, text: @post.body)
    end

    if result['ok']
      @post.touch(:published_at)
      # TODO: save response
    else
      # error handle
    end

    [result['ok'], result]
  end
end
