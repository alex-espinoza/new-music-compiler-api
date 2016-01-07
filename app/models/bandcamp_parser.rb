# BandcampParser gets newest albums from a bandcamp artist/label page based on the source's url (which should be a bandcamp url)
# Currently uses import.io to parse the web page and HTTParty to query the import.io API to get the page's content in JSON format
# http://api.docs.import.io/

class BandcampParser
  include HTTParty
  base_uri "https://api.import.io"

  def initialize(source)
    @source = source
    @source_url = source.url
    @import_io_api_key = Rails.application.secrets.import_io_api_key
  end

  def get_newest_entries
    response = self.class.get("/store/connector/_magic", query: {url: @source_url, _apikey: @import_io_api_key})
    newest_entries = response["tables"][0]["results"]
    newest_entries
  end
end
