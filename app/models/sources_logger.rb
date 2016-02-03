# Logs processing info and errors for sources.rake jobs
# Implement emailing on errors

class SourcesLogger
  def self.log_info(info)
    info_log_file = ActiveSupport::Logger.new('log/sources.rake.log')
    time = Time.now
    info_text = "[#{time}] - #{info}"
    puts info_text
    info_log_file.info(info_text)
    info_log_file.close
  end

  def self.log_error(error)
    error_log_file = ActiveSupport::Logger.new('log/sources.rake.err')
    time = Time.now
    error_text = "[#{time}] - #{error}"
    puts error_text
    @error_log_file.info(error_text)
    @error_log_file.close
  end
end
