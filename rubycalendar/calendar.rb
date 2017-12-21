require './rubycalendar/event'
require 'date'

class Calendar
  attr_reader :name, :events

  def initialize(name)
    @name = name
    @events = []
  end

  def add_event(name, params = {})
    event = Event.new(name, params)
    @events.push(event)
  end

  def events_with_name(name)
    matching_events = @events.select { |event| event.name == name }

    if matching_events
      return matching_events
    else
      raise ArgumentError.new("No event found with name: #{name}") 
    end
  end

  def events_for_date(date)
    @events.select { |event| event.is_this_date_in_range?(date) }
  end

  def events_for_today
    events_for_date(Date.today)
  end

  def events_for_this_week
    @events.select { |event| event.is_this_event_within_a_week? }
  end

  def update_events(name, params = {})
    events_with_name(name).map { |event| event.update_params(params) }
  end

  def remove_events(name)
    events_with_name(name).each { |event| @events.delete(event) }
  end
end
