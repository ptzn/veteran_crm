class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email_address   :string           not null, indexed
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
