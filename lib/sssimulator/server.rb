require 'thin'
require 'sinatra/base'
require 'haml'
require 'json'
require 'uri'
require 'yaml'

require 'sinatra/environment'
require 'sinatra/logging'
require 'sinatra/subdomains'

module Sssimulator
  class Server < Sinatra::Base

    register Sinatra::Environment
    register Sinatra::Logging
    register Sinatra::Subdomain

    configure :production, :development do
      enable :logging
    end

    configure :test, :development do
    end

    set :root, File.dirname(File.expand_path(__FILE__)) + '/../..'
    enable :raise_errors
    enable :dump_errors

    get "/" do
      log_request

      haml :index

    end

    get '/*/*.*' do |profile,filename,ext|
      file = File.join(settings.root, "storage", profile+'-'+filename+'.'+ext)
      send_file(file, :disposition => 'attachment')
    end

    post "/" do
      log_request
      content_type :html
      if request.xhr?
        image = Uploader.new(params).process
        puts "Medium upload complete: #{image}"
        status 204
      else
        status 301
      end
      ''
    end

    # start the server if ruby file executed directly
    # run! if app_file == $0
  end
end
