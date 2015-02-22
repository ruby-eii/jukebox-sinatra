require 'mongoid'

if development?
  require 'better_errors'
  require "sinatra/reloader" 
end

configure do
  set :bind, "0.0.0.0"
  Mongoid.load!("config/mongoid.yml")
  Dir["models/**/*.rb"].each {|model| require_relative model}
end

configure :development do
  use BetterErrors::Middleware  
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

