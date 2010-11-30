class GoogleGeocoding
  include HTTParty
  # base url for google maps web services
  base_uri 'http://maps.googleapis.com/maps/api/geocode/'
  
  #format :json

  ##
  # request data from google maps web services and return json object
  # @param suburb - string of suburb
  # @param state - string of state
  # @param postcode - string of postcode
  # @return nil or hash geo data with lat and lng
  def self.request suburb, state, postcode
    # invalid arguments
    return nil if suburb.empty? or state.empty? or postcode.empty?
    begin
      address = "#{suburb},#{state},#{postcode}"
      response = get '/json?&sensor=false&address=' << CGI.escape(address)
      # return nil if the request is failed
      return nil if response.nil? or response['status'].nil? or not response['status'].to_s.eql? 'OK'
      # return the lat and lng hash data
      # for example: :lat => 37.4219720, :lng => -122.0841430
      puts "---> got geo data for address '#{address}'"
      return response['results'][0]['geometry']['location']
    rescue
      # ignore the falied request
    end
  end

end