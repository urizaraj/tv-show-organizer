require './environment'

use Rack::MethodOverride

use UserController
use ShowController
run ApplicationController
