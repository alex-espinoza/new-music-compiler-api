namespace :sources do
  desc "Get new entries from each source"
  task fetch_new_entries: :environment do
  	sources = Source.all
    sources.each do |source|
      source_identifier = SourceIdentifier.new(source)
      parser = source_identifier.identify_parser
      newest_entries = parser.get_newest_entries
    end
  end
end
