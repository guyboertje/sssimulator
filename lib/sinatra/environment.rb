module Sinatra

  module Environment
    class EnvironmentNotConfiguredError < RuntimeError
    end

    def load_environment_from_yml
      if File.exist?('./config/environment.yml')
        config = YAML.load_file('./config/environment.yml')[settings.environment.to_s]
        config.each do |key, value|
          set key.to_sym, value
        end
      end
    end

    def self.registered(app)
      app.load_environment_from_yml
    end
  end
end
