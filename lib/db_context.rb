class DbContext
  class << self
    
    def connect_to_default_database!
      logger.info "DB Context: Changing to default database configuration"
      ActiveRecord::Base.establish_connection(database_configuration([:default]))
    end
    
    def database_configuration(name)
      env = name == :default ? Rails.env : "#{name}_#{Rails.env}"
      YAML.load(File.read(Rails.configuration.database_configuration_file))[env]
    end
    
    def logger
      Rails.logger
    end
    
    def connect_to_contextual_database!(name)
      logger.info "DB Context: Changing to #{name} database configuration"
      ActiveRecord::Base.establish_connection(database_configuration(name))
    end
    
    def db_context(name, &block)
      connect_to_contextual_database!(name)
        return_value = yield
      connect_to_default_database!
      return_value
    end
  end
end