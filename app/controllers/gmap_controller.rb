class GmapController < ApplicationController

  #
  # crawl the google maps web services using postcode and suburb name
  #
  def crawl
    puts '=> start to crawl google maps web services...'
    puts '=> configuring...'

    ## there is a limit of 2500 requests per day from google maps web services
    # @url http://code.google.com/apis/maps/documentation/geocoding/
    # @see Usage Limits
    puts '=> begin the task'
    begin
      Postcode.where('latitude IS NULL OR longtitude IS NULL').limit(2000).each do |p| # Postcode object
        puts "==> getting geo data for ##{p.id}"
        begin
          geo_data = GoogleGeocoding.request p.suburb, p.state, p.postcode
          next if geo_data.nil?
          p.latitude = geo_data['lat']
          p.longtitude = geo_data['lng']
          p.save
        rescue Exception => e
          logger.error e.message
          break;
        end
        logger.info "Finished update lat and lng for record ##{p.id}"
      end
    rescue Exception => e
      logger.error e.message
    else
    end
    puts '=> end of task.'
  end

  def index
    begin
      @postcodes = Postcode.where('latitude IS NOT NULL AND longtitude IS NOT NULL')
    rescue
    end
  end

end
