# EntrySavers check to see if the source's last saved entry matches the first entry in the array of newest entries.
# If so, that means the array of entries aren't new and that we already have them. We don't need to save these entries as they already exist.
# If not, that means there are new entries in the array we do not have yet. We should save the ones that we don't have, and stop at the one we do.

class BandcampEntrySaver
  def initialize(source)
    @source = source
    @newest_entries = nil
    @last_saved_entry = @source.entries.last
  end

  def check_newest_entries(newest_entries)
    @newest_entries = newest_entries
    first_entry = @newest_entries.first
    first_entry_artist_and_album = "#{first_entry['artist_name']} - #{first_entry['album_name']}"

    if first_entry_artist_and_album != @last_saved_entry.try(:title)
      save_newest_entries
    end
  end

  def save_newest_entries
    # add in the searching of album id in the newest entry hash, cut the hash there, reverse hash, then save to keep things in reverse chronological order
    @newest_entries.each do |entry|
      artist_and_album = "#{entry['artist_name']} - #{entry['album_name']}"
  
      if artist_and_album == @last_saved_entry.try(:title)
        break
      else
        new_entry = @source.entries.build(
          title: artist_and_album,
          description: "",
          embed_data: "",
          url: entry["album_link"]
        )
        new_entry.save!

        puts "#{artist_and_album} - was saved!"
      end
    end
  end
end
