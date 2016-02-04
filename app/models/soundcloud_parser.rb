# SoundcloudParser gets newest playlists from a soundcloud user based on the source's soundcloud_id
# Currently uses soundcloud API and ruby wrapper
# http://developers.soundcloud.com/
# Might be able to just use HTTParty since we're only hitting one endpoint

class SoundcloudParser
  def initialize(source)
    @source = source
    @source_soundcloud_id = @source.soundcloud_id
    @source_id = @source.id
    @soundcloud_client_id = Rails.application.secrets.soundcloud_client_id
    @soundcloud = Soundcloud.new(client_id: @soundcloud_client_id)
  end

  def get_newest_entries
    playlists = get_playlists
    newest_entries = compile_newest_entries(playlists)
    newest_entries
  end

  def get_playlists
    begin
      playlists = @soundcloud.get("/users/#{@source_soundcloud_id}/playlists")
    rescue SoundCloud::ResponseError => e
      SourcesLogger.log_error(e)
      playlists = nil
    end

    playlists
  end

  def compile_newest_entries(playlists)
    newest_entries = []

    playlists.each do |playlist|
      url = playlist["permalink_url"]

      if Entry.exists?(url: url, source_id: @source_id)
        SourcesLogger.log_info("[#{@source.name}] - No new playlists were found or newest are done being compiled.")
        break
      else
        playlist.delete("tracks") # don't care about this info and it takes up too much space
        newest_entries.push(playlist)
      end
    end

    newest_entries
  end
end
