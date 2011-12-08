require './app'

use Rack::ShowExceptions
run Sssimulator::Server.new
