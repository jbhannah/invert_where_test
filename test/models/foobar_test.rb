require "test_helper"

class FoobarTest < ActiveSupport::TestCase
  test "defaults #expired_at to 30 days from now" do
    travel_to "2021-12-10 00:04:00" do
      assert Foobar.new.expires_at == "2022-01-09 00:04:00"
    end
  end

  test "is .active if the timestamp is in the future" do
    foobar = Foobar.first
    travel_to 1.minute.before(foobar.expires_at) do
      assert_includes Foobar.active, foobar
    end
  end

  test "is .active if the timestamp is now" do
    foobar = Foobar.first
    travel_to foobar.expires_at do
      assert_includes Foobar.active, foobar
    end
  end

  test "is not .active if the timestamp is in the past" do
    foobar = Foobar.first
    travel_to 1.minute.after(foobar.expires_at) do
      assert (not Foobar.active.include?(foobar))
    end
  end
end
