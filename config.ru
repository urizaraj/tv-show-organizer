require './environment'

use Rack::MethodOverride

use UserController
use ShowController
use UserShowController
run ApplicationController
