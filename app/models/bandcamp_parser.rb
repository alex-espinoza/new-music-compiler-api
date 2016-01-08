# BandcampParser gets newest albums from a bandcamp artist/label page based on the source's url (which should be a bandcamp url)
# Currently uses import.io to parse the web page and HTTParty to query the import.io API to get the page's content in JSON format
# http://api.docs.import.io/

class BandcampParser
  include HTTParty
  base_uri "https://api.import.io"

  def initialize(source)
    @source = source
    @source_url = @source.url
    @import_io_api_key = Rails.application.secrets.import_io_api_key
  end

  def get_newest_entries
    response = self.class.get("/store/connector/c7a0760e-88f9-4bb6-9fd0-9729e2e44ac6/_query", query: {input: "webpage/url:#{@source_url}", _apikey: @import_io_api_key})
    newest_entries = response["results"]
    newest_entries
  end
end
