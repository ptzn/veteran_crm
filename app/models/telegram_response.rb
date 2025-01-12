class TelegramResponse < ApplicationRecord
  belongs_to :post
end

# == Schema Information
#
# Table name: telegram_responses
#
#  id           :bigint           not null, primary key
#  raw_response :jsonb
#  success      :boolean          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  post_id      :bigint           not null, indexed
#
