require "test_helper"

class TelegramResponseTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:post)
  end
end
