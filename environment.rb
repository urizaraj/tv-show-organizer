ENV['SINATRA_ENV'] ||= 'development'

require 'bundler'

Bundler.require(:default, ENV['SINATRA_ENV'])

set :database, adapter: 'sqlite3', database: "db/#{ENV['SINATRA_ENV']}.sqlite"

require 'sinatra/reloader'
require_all 'app'