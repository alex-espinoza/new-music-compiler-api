# BandcampParser gets newest albums from a bandcamp artist/label page based on the source's url (which should be a bandcamp url)

class BandcampParser
  def initialize(source)
    @source = source
    @source_url = source.url
  end

  def get_newest_entries
    puts @source_url
  end
end
