class TelegramService::SendMessage < BaseService
  def initialize(post)
    @post = post
    @chat_id = Config[:telegram][:channel_id]
    @bot = Telegram.bot
  end

  def call
    result = send_media? ? send_media : send_text

    @post.touch(:published_at) if result['ok']

    @post.telegram_responses.create(
      success: !!result['ok'],
      raw_response: result
    )

    [result['ok'], result]
  end

  private

  def send_media?
    @post.attachments.attached?
  end

  def send_media
    if @post.attachments.size == 1
      @post.attachments.first.open do |file|
        @bot.send_photo(chat_id: @chat_id, photo: file, caption: @post.body)
      end
    else
      attachments = @post.attachments.map do |blob|
        tmp_file = Tempfile.open
        tmp_file.binmode
        blob.download { |chunk| tmp_file.write(chunk) }
        tmp_file.flush
        tmp_file.rewind
        tmp_file
      end

      begin
        media = []
        # the trick is to set caption property only for the first element of an array. In this case telegram will show that caption below the media content.
        media << {type: 'photo', media: attachments.first.open, caption: @post.body}
        attachments.from(1).each do |attachment|
          media << {type: 'photo', media: attachment.open}
        end

        @bot.send_media_group(chat_id: @chat_id, media:)
      ensure
        attachments.each do |tmp_file|
          tmp_file.close
          tmp_file.unlink
        end
      end
    end
  end

  def send_text
    @bot.send_message(chat_id: @chat_id, text: @post.body)
  end
end
