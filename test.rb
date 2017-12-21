#Each calendar must have a name.

#Events must have a name and a start time. Additionally, each event should have either an end time or be flagged as an all-day event.

# Each event may also have an optional location. If an event has a location, the location must have a name and can also have an address, city, state, and zip

require "minitest/autorun"
require './rubycalendar/calendar'

cal = Calendar.new("Cathy's Calendar")

describe 'Ruby Calendar' do
  before do
    # @cal = Calendar.new("Cathy's Calendar")
  end

  describe "Calendar Model" do
    it "Each calendar must have a name, otherwise an e" do
      assert_raises ArgumentError do
        @cal = Calendar.new()
      end
    end


    it "An error should occur if no name is given" do
    end

    it "" do
    end

    







  end

  describe "Event Model" do
    it "It should take and show a name param" do
    end

    it "An error should occur if no name is given" do
    end

    it "It should take an event start time" do
    end

    it "An error should occur if no name is given" do
    end

    it "Optional params are address, city, state, and zip" do
    end
  end

  describe "Location Model" do
    it "It should take and show a name param" do
    end

    it "An error should occur if no name is given" do
    end

    it "Optional params are address, city, state, and zip" do
    end
  end

#   describe "when asked about blending possibilities" do
#     it "won't say no" do
#       @meme.to_s.wont_match /^no/i
#     end
#   end
end


#must equal

# class TestMeme < Minitest::Test
#   def setup
#     @meme = Meme.new
#   end

#   def test_that_kitty_can_eat
#     assert_equal "OHAI!", @meme.i_can_has_cheezburger?
#   end

#   def test_that_it_will_not_blend
#     refute_match /^no/i, @meme.will_it_blend?
#   end

#   def test_that_will_be_skipped
#     skip "test this later"
#   end
# end