ENV['RACK_ENV'] = 'test'

require 'rubygems'
require 'bundler'
require 'rack/test'

# require 'cgi'
Bundler.setup(:default, :test)
# set :environment, :test # rspec ignoring?
# set :raise_errors, true
# set :logging, false

dir = File.dirname(File.expand_path(__FILE__))
$LOAD_PATH.unshift(dir, 'lib')

require 'sssimulator'

RSpec.configure do |config|
  config.mock_with :rspec
end

def app
  Sssimulator::Server
end

class SessionData
  def initialize(cookies)
    @cookies = cookies
    @data = cookies['rack.session']
    if @data
      @data = @data.unpack("m*").first
      @data = Marshal.load(@data)
    else
      @data = {}
    end
  end

  def [](key)
    @data[key]
  end

  def []=(key, value)
    @data[key] = value
    session_data = Marshal.dump(@data)
    session_data = [session_data].pack("m*")
    @cookies.merge("rack.session=#{Rack::Utils.escape(session_data)}", URI.parse("//example.org//"))
    raise "session variable not set" unless @cookies['rack.session'] == session_data
  end
end
