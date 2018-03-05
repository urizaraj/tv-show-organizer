require './environment'

use Rack::MethodOverride

use UserController
run ApplicationController
