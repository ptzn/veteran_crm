class Post < ApplicationRecord
  has_one_attached :media do |media|
    media.variant :thumb, resize_to_limit: [300, 300] # preprocessed: true
  end

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
#  job_id       :bigint
#
