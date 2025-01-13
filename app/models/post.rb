class Post < ApplicationRecord
  has_many_attached :attachments do |attachment|
    attachment.variant :thumb, resize_to_limit: [300, 300] # preprocessed: true
    attachment.variant :xthumb, resize_to_limit: [100, 100] # preprocessed: true
  end

  has_many :telegram_responses, dependent: :delete_all

  scope :upcoming, -> { where.not(scheduled_at: nil).order(scheduled_at: :asc) }

  def published?
    published_at.present?
  end
end

# == Schema Information
#
# Table name: posts
#
#  id           :bigint           not null, primary key
#  body         :text
#  published_at :datetime
#  scheduled_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  job_id       :string
#
