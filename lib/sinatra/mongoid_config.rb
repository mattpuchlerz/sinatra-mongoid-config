require 'sinatra/base'
require 'mongoid'
require 'mongoid_config'
  
module Sinatra
  module MongoidConfig
    
    def self.registered app
      Mongoid.configure do |c|
        c.sinatra_app= app
      end
      
      app.set :mongo_host,     ENV['MONGO_HOST'] || 'localhost'
      app.set :mongo_db,       ENV['MONGO_DB']   || self.app_to_db_name(app)
      app.set :mongo_port,     ENV['MONGO_PORT'] || Mongo::Connection::DEFAULT_PORT
      app.set :mongo_user,     ENV['MONGO_USER']
      app.set :mongo_password, ENV['MONGO_PASSWORD']
    end
    
    private
    
    # Inspired by the ActiveSupport Inflector's #underscore method
    def self.app_to_db_name app
      name = app.
        to_s.
        gsub(/::/, '_').
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("-", "_").
        downcase
      
      "#{ name }_#{ app.environment }"
    end
    
  end
  
  register MongoidConfig
end
