require "test_helper"

class PostTest < ActiveSupport::TestCase
  context 'associations' do
    should have_many(:telegram_responses)
  end
end
