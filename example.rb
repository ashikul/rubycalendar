require './rubycalendar/calendar'

# Example copied from the example app interaction

cal = Calendar.new("Cathy's Calendar")

cal.add_event("Cathy's Party",             # name is required
  all_day: false,                          # all_day is optional (defaults to false)
  start_time: Time.new(2017, 8, 4, 20, 0), # start_time is required
  end_time: Time.new(2017, 8, 4, 23, 59),  # end_time is required UNLESS all_day is true
  location: {                              # location is optional
    name: 'Barcade',                         # name is required
    address: '148 W 24th St',                # address is optional
    city: 'New York',                        # city is optional
    state: 'NY',                             # state is optional
    zip: '10011'                             # zip is optional
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
  start_time: 22
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

puts cal.events
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

puts cal.events_with_name("Cathy's Party")
# Cathy's Party
# ...Starts: August 4, 2017 at 08:00 pm
# ...Ends: August 4, 2017 at 11:59 pm
# ...Location: Barcade, 148 W 24th St, New York, NY, 10011

puts cal.events_for_date(Date.new(2017, 8, 4))
# Cathy's Party
# ...Starts: August 4, 2017 at 08:00 pm
# ...Ends: August 4, 2017 at 11:59 pm
# ...Location: Barcade, 148 W 24th St, New York, NY, 10011

# Assuming today is August 5th, 2017
# puts cal.events_for_today
puts cal.events_for_date('August 5th, 2017')
# Brunch with Friends
# ...Starts: August 5, 2017 at 11:30 am
# ...Ends: August 5, 2017 at 01:00 pm
# ...Location: Jack's Wife Freda, 224 Lafayette St, New York, NY, 10012
# ---------------------------------------------------------------------
# Dog Walking
# ...Starts: August 5, 2017 at 03:30 pm
# ...Ends: August 5, 2017 at 04:30 pm
# ...Location: Brooklyn Paws, Inc., 110 York St, Brooklyn, NY, 11201

puts cal.update_events('Cipherhealth Interview',
  start_time: Time.new(2017, 8, 8, 15, 00),
  end_time: Time.new(2017, 8, 8, 16, 30)
)
# Cipherhealth Interview
# ...Starts: August 8, 2017 at 03:00 pm
# ...Ends: August 8, 2017 at 04:30 pm
# ...Location: Cipherhealth, 555 8th Ave, New York, NY, 10018

puts cal.remove_events("Andy Warhol's Birthday")