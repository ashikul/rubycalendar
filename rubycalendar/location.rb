class Location
  attr_accessor :name, :address, :city, :state, :zip

  def initialize(params)
    raise ArgumentError, 'Location name is required' unless params[:name]

    @name = params[:name]
    @address = params[:address]
    @city = params[:city]
    @state = params[:state]
    @zip = params[:zip]
  end

  def to_s
    location_to_string = [@name, @address, @city, @state, @zip].reject { |e| e.to_s.empty? }.join(', ')
  end
end
