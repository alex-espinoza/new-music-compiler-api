# EntrySavers check to see if the source's last saved entry matches the first entry in the array of newest entries.
# If so, that means the array of entries aren't new and that we already have them. We don't need to save these entries as they already exist.
# If not, that means there are new entries in the array we do not have yet. We should save the ones that we don't have, and stop at the one we do.

class SoundcloudEntrySaver
  def initialize(source)
    @source = source
    @newest_entries = nil
  end

  def check_newest_entries(newest_entries)
    @newest_entries = newest_entries
    save_newest_entries
  end

  def save_newest_entries
    @newest_entries.each do |entry|
      new_entry = @source.entries.build(
        title: entry["title"],
        description: entry["description"],
        embed_data: entry["uri"],
        url: entry["permalink_url"],
        image_url: entry["artwork_url"],
        published_at: Time.parse(entry["created_at"])
      )
      new_entry.save!

      SourcesLogger.log_info("[#{@source.name}] - New entry [#{new_entry.title}] was saved.")
    end
  end
end
