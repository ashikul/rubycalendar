require "minitest/autorun"
require './rubycalendar/calendar'

class TestExample < Minitest::Test

  def test_the_example_from_readme

    cal = initialize_calendar_with_events()
 
    assert_equal output_for_all_events, format_event(cal.events)

    assert_equal output_for_cathy, format_event(cal.events_with_name("Cathy's Party"))

    assert_equal output_for_cathy, format_event(cal.events_for_date(Date.new(2017, 8, 4)))

    assert_equal output_for_august_five, format_event(cal.events_for_date('August 5th, 2017'))

    assert_equal output_for_andy, format_event(cal.remove_events("Andy Warhol's Birthday"))

  end

  def test_for_argument_errors

    cal = Calendar.new("Test")

    #Empty calendar name
    assert_raises ArgumentError do  
      cal2 = Calendar.new()
    end

    #Empty event
    assert_raises ArgumentError do  
      cal.add_event() 
    end

    #Empty location params
    assert_raises ArgumentError do  
      cal.add_event("Cathy's Party",             
          all_day: false,                           
          start_time: Time.new(2017, 8, 4, 20, 0),  
          end_time: Time.new(2017, 8, 4, 23, 59),   
          location: {}
      ) 
    end

    #Missing end_time param since all day is false
    assert_raises ArgumentError do  
      cal.add_event("Cathy's Party",             
          all_day: false,                           
          start_time: Time.new(2017, 8, 14, 20, 0)
      ) 
    end

    #Start_time > end_time
    assert_raises ArgumentError do  
      cal.add_event("Cathy's Party",             
          all_day: false,                           
          start_time: Time.new(2017, 8, 14, 20, 0),  
          end_time: Time.new(2017, 8, 4, 23, 59)   
      ) 
    end

    #Invalid date parsed
    assert_raises ArgumentError do  
      cal.add_event("Cathy's Party",             
          all_day: true,                           
          start_time:'qwertasdf'
      ) 
    end

  end

  def format_event(input)
    input.map(&:to_s).join('')
  end

  def initialize_calendar_with_events
    cal = Calendar.new("Cathy's Calendar")
    cal.add_event("Cathy's Party",             
          all_day: false,                           
          start_time: Time.new(2017, 8, 4, 20, 0),  
          end_time: Time.new(2017, 8, 4, 23, 59),   
          location: {                               
            name: 'Barcade',                          
            address: '148 W 24th St',                 
            city: 'New York',                        
            state: 'NY',                             
            zip: '10011'                             
          }
        )

    cal.add_event('Brunch with Friends',
      start_time: Time.new(2017, 8, 5, 11, 30),
      end_time: Time.new(2017, 8, 5, 13, 0),
      location: {
        name: "Jack's Wife Freda",
        address: '224 Lafayette St',
        city: 'New York',
        state: 'NY',
        zip: '10012'
      }
    )

    cal.add_event('Dog Walking',
      start_time: Time.new(2017, 8, 5, 15, 30),
      end_time: Time.new(2017, 8, 5, 16, 30),
      location: {
        name: 'Brooklyn Paws, Inc.',
        address: '110 York St',
        city: 'Brooklyn',
        state: 'NY',
        zip: '11201'
      }
    )

    cal.add_event("Andy Warhol's Birthday",
      all_day: true,
      start_time: Time.new(2017, 8, 6)
    )

    cal.add_event('Cipherhealth Interview',
      start_time: Time.new(2017, 8, 8, 14, 00),
      end_time: Time.new(2017, 8, 8, 15, 30),
      location: {
        name: 'Cipherhealth',
        address: '555 8th Ave',
        city: 'New York',
        state: 'NY',
        zip: '10018'
      }
    )

    cal.add_event('VACATION!',
      start_time: Time.new(2017, 8, 19, 10),
      end_time: Time.new(2017, 8, 27, 14, 0),
      location: {
        name: 'Tulum, Mexico'
      }
    )

    cal
  end

  def output_for_all_events
    <<~STRING
    # Cathy's Party
    # ...Starts: August 4, 2017 at 08:00 pm
    # ...Ends: August 4, 2017 at 11:59 pm
    # ...Location: Barcade, 148 W 24th St, New York, NY, 10011
    # ---------------------------------------------------------------------
    # Brunch with Friends
    # ...Starts: August 5, 2017 at 11:30 am
    # ...Ends: August 5, 2017 at 01:00 pm
    # ...Location: Jack's Wife Freda, 224 Lafayette St, New York, NY, 10012
    # ---------------------------------------------------------------------
    # Dog Walking
    # ...Starts: August 5, 2017 at 03:30 pm
    # ...Ends: August 5, 2017 at 04:30 pm
    # ...Location: Brooklyn Paws, Inc., 110 York St, Brooklyn, NY, 11201
    # ---------------------------------------------------------------------
    # Andy Warhol's Birthday
    # ...Date: August 6, 2017 (All Day)
    # ---------------------------------------------------------------------
    # Cipherhealth Interview
    # ...Starts: August 8, 2017 at 02:00 pm
    # ...Ends: August 8, 2017 at 03:30 pm
    # ...Location: Cipherhealth, 555 8th Ave, New York, NY, 10018
    # ---------------------------------------------------------------------
    # VACATION!
    # ...Starts: August 19, 2017 at 10:00 am
    # ...Ends: August 27, 2017 at 02:00 pm
    # ...Location: Tulum, Mexico
    # ---------------------------------------------------------------------
    STRING
  end

  def output_for_cathy
    <<~STRING
    # Cathy's Party
    # ...Starts: August 4, 2017 at 08:00 pm
    # ...Ends: August 4, 2017 at 11:59 pm
    # ...Location: Barcade, 148 W 24th St, New York, NY, 10011
    # ---------------------------------------------------------------------
    STRING
  end

  def output_for_august_five
    <<~STRING
    # Brunch with Friends
    # ...Starts: August 5, 2017 at 11:30 am
    # ...Ends: August 5, 2017 at 01:00 pm
    # ...Location: Jack's Wife Freda, 224 Lafayette St, New York, NY, 10012
    # ---------------------------------------------------------------------
    # Dog Walking
    # ...Starts: August 5, 2017 at 03:30 pm
    # ...Ends: August 5, 2017 at 04:30 pm
    # ...Location: Brooklyn Paws, Inc., 110 York St, Brooklyn, NY, 11201
    # ---------------------------------------------------------------------
    STRING
  end

  def output_for_new_cipherhealth
    <<~STRING
    # Cipherhealth Interview
    # ...Starts: August 8, 2017 at 03:00 pm
    # ...Ends: August 8, 2017 at 04:30 pm
    # ...Location: Cipherhealth, 555 8th Ave, New York, NY, 10018
    # ---------------------------------------------------------------------
    STRING
  end

  def output_for_andy
    <<~STRING
    # Andy Warhol's Birthday
    # ...Date: August 6, 2017 (All Day)
    # ---------------------------------------------------------------------
    STRING
  end  
end
