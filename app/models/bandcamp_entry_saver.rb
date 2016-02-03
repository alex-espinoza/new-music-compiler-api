# EntrySavers check to see if the source's last saved entry matches the first entry in the array of newest entries.
# If so, that means the array of entries aren't new and that we already have them. We don't need to save these entries as they already exist.
# If not, that means there are new entries in the array we do not have yet. We should save the ones that we don't have, and stop at the one we do.

class BandcampEntrySaver
  def initialize(source)
    @source = source
    @newest_entries = nil
  end

  def check_newest_entries(newest_entries)
    @newest_entries = newest_entries
    save_newest_entries
  end

  def format_bandcamp_entry_title(entry)
    if entry['artist_name']
      title = "#{entry['artist_name']} - #{entry['album_name']}"
    else
      title = entry['album_name']
    end

    title
  end

  def save_newest_entries
    @newest_entries.each do |entry|
      artist_and_album = format_bandcamp_entry_title(entry)
  
      new_entry = @source.entries.build(
        title: artist_and_album,
        description: "",
        embed_data: entry["embed_data"],
        url: entry["album_url"],
        image_url: entry["album_art_image"],
        published_at: Time.parse(entry["release_date"])
      )
      new_entry.save!

      SourcesLogger.log_info("[#{@source.name}] - New entry [#{artist_and_album}] was saved.")
    end
  end
end
