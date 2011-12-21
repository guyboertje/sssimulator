require 'sinatra/base'

module Sinatra
  module Logging

    module Helpers

      def logger
        request.logger
      end

      def log_request
        logger.info "|| params  : #{params.inspect}"
      end
      def log_ai(data)
        logger.info "|| > #{data.ai}"
      end

      def log_this(data)
        logger.info "|| > #{data}"
      end

    end

    def self.registered(app)
      app.use Rack::Logger
      app.helpers Sinatra::Logging::Helpers
    end
  end
end
