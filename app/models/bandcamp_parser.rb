# BandcampParser gets newest albums from a bandcamp artist/label page based on the source's url (which should be a bandcamp url)
# Currently uses import.io to parse the web page and HTTParty to query the import.io API to get the page's content in JSON format
# http://api.docs.import.io/

class BandcampParser
  include HTTParty
  base_uri "https://api.import.io"

  def initialize(source)
    @source = source
    @source_url = @source.url
    @source_id = @source.id
    @import_io_api_key = Rails.application.secrets.import_io_api_key
  end

  def get_newest_entries
    album_urls = get_album_urls
    
    if album_urls
      newest_entries = compile_newest_entries(album_urls)
    else
      newest_entries = nil
    end

    newest_entries
  end

  def get_album_urls
    begin
      response = self.class.get("/store/connector/c7a0760e-88f9-4bb6-9fd0-9729e2e44ac6/_query", query: {input: "webpage/url:#{@source_url}", _apikey: @import_io_api_key})
      album_urls = response["results"]
    rescue HTTParty::Error => e
      SourcesLogger.log_error(e)
      album_urls = nil
    end

    album_urls
  end

  def compile_newest_entries(album_urls)
    newest_entries = []

    album_urls.each do |album_url|
      url = album_url["album_link"]

      if Entry.exists?(url: url, source_id: @source_id)
        SourcesLogger.log_info("[#{@source.name}] - No new albums were found or newest are done being compiled.")
        break
      else
        new_entry = get_album_information(url)
        newest_entries.push(new_entry)
      end
    end

    newest_entries.compact!
    newest_entries
  end

  def get_album_information(url)
    begin
      response = self.class.get("/store/connector/0f409075-4346-4508-8d4f-3df0b5a64554/_query", query: {input: "webpage/url:#{url}", _apikey: @import_io_api_key})
      album_information = response["results"][0]
    rescue HTTParty::Error => e
      SourcesLogger.log_error(e)
      album_information = nil
    end

    album_information
  end
end
