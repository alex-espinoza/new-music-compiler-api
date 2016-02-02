namespace :sources do
  desc "Get new entries from each source"
  task fetch_new_entries: :environment do
  	sources = Source.all
    
    sources.each do |source|
      source_identifier = SourceIdentifier.new(source)
      parser = source_identifier.identify_parser
      newest_entries = parser.get_newest_entries

      if newest_entries
        source.update_last_checked_at
        entry_saver = source_identifier.identify_entry_saver
        entry_saver.check_newest_entries(newest_entries)
      end
    end
  end
end
