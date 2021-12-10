require "test_helper"

class FoobarTest < ActiveSupport::TestCase
  test "sets expired_at to 30 days from now" do
    travel_to "2021-12-10 00:04:00" do
      assert Foobar.new.expires_at == "2022-01-09 00:04:00"
    end
  end
end
