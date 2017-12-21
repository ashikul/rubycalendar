require './rubycalendar/location'
require 'chronic'
require 'active_support'
require 'active_support/core_ext'

class Event
  attr_accessor :start_time, :end_time, :name, :location, :all_day

  def initialize(name, params = {})
    raise ArgumentError.new("Event name is required" ) unless name
    @name = name
    update_params(params)
  end

  def update_params(params = {})

    set_start_time(params[:start_time])

    set_end_time_and_all_day(params[:end_time], params[:all_day])

    check_time_order?

    set_location(params[:location]) unless params[:location].nil?
    
  end
 
  def is_this_date_in_range?(date)
    dateParsed = Chronic.parse(date, :guess => false)
    raise ArgumentError.new("Date cannot be parsed" ) unless dateParsed

    # Since guess is false, we don't assume the default time is assumed for a date
    # and instead, we may get an array of dates from Chronic, as a span object
    if dateParsed.class == Chronic::Span
      return dateParsed.include?(@start_time) && dateParsed.include?(@end_time)
    else
      return dateParsed.between?(@start_time, @end_time)
    end

  end

  def is_this_event_within_a_week?
    @start_time.between?(Date.today, Date.today + 7)
  end

  def to_s
    event_to_string = "# #{@name}\n" 

    if @all_day
      event_to_string += "# ...Date: #{@start_time.strftime("%B %-e, %Y")} (All Day)\n"
    else
      event_to_string += "# ...Starts: #{@start_time.strftime("%B %-e, %Y at %I:%M %P")}\n" \
                           "# ...Ends: #{@end_time.strftime("%B %-e, %Y at %I:%M %P")}\n"
    end

    event_to_string += "# ...Location: #{@location}\n" unless @location.nil?
    
    event_to_string += "# ---------------------------------------------------------------------\n"
    event_to_string
  end

  private

  def set_start_time(start_time)
    raise ArgumentError.new("Event start_time is required" ) unless start_time

    @start_time = Chronic.parse(start_time.to_s)

    raise ArgumentError.new("Start time cannot be parsed" ) unless @start_time
  end

  def set_end_time_and_all_day(end_time, all_day)

    raise ArgumentError.new("Either event end_time or all_day:true is required") unless end_time || all_day == true
    
    if(all_day == true)

      @all_day = true

      @end_time = Date.parse(@start_time.to_s).end_of_day

    else

      raise ArgumentError.new("Event end_time is required since this is not an all day event" ) unless end_time

      @end_time = Chronic.parse(end_time.to_s)

      raise ArgumentError.new("End time cannot be parsed" ) unless @end_time

      @all_day = false
      
    end
  end

  def check_time_order?
     if(@start_time > @end_time)
      raise ArgumentError.new('Start date should be lower than the end date')
     end
  end

  def set_location(location)
    @location = Location.new(location)
  end

end
