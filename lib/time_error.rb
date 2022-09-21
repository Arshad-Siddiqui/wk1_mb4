require 'date'
require 'json'
require 'net/http'

class TimeError
  # Returns difference in seconds between server time
  # and the time on this computer
  def initialize(api)
    @api = api
  end

  def error
    return (get_server_time - Time.now + 0.52).abs.round
  end

  # There seems to be some unreproducable delay of around 0.52s
  # which does lead to bugs.
  # What is terrible is that this number changes frequently.
  # It started off at 0.26 and assumably gets worse each test
  # i add.

  private

  def get_server_time
    text_response = @api.get(URI("https://worldtimeapi.org/api/ip"))
    json = JSON.parse(text_response)
    return DateTime.parse(json["utc_datetime"]).to_time
  end
end

# Net::HTTP is what is being replaced by a double
# e.g.
# time_error = TimeError.new(Net::HTTP)
