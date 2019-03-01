class SecretFile
  # attr_reader :data

  def initialize(secret_data, logger)
    @data = secret_data
    @logger = logger
  end

  def data # replaces attr_reader :data
    @logger.create_log_entry
    @data
  end
end

class SecurityLogger
  def create_log_entry
    puts "creating log entry"
    # ... implementation omitted ...
  end
end

sf = SecretFile.new("abbrakadabbra", SecurityLogger.new)
sf.data
