# SourceIdentifier figures out which parser to use based on the source's parser format.
# Need this so each specific parser knows how to fetch new entries for each website I want new music from.

class SourceIdentifier
  def initialize(source)
    @source = source
  end

  def identify_parser
    parser_class_name = @source.parser_format.capitalize + "Parser"
    parser = Object.const_get(parser_class_name).new(@source)
    parser
  end
end
