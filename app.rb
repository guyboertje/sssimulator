$LOAD_PATH.unshift 'lib'
require 'sssimulator'

# start the server if ruby file executed directly
Sssimulator::Server.run! if __FILE__ == $0

