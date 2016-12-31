require './app/racker.rb'

use Rack::Reloader
use Rack::Session::Cookie, key: 'rack.session', secret: 'secretKey'
use Rack::Static, :urls => ['/css', '/js'], :root => 'public'
run Racker