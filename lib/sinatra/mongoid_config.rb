require 'sinatra/base'
require 'mongoid'

module Mongoid
  class Config
    
    # Sets a reference to the Sinatra app in which
    # this extension is registered.
    def sinatra_app= app
      @sinatra_app = app unless @sinatra_app
    end
    
    # If the database connection doesn't already exist,
    # attempt to connect using options from the Sinatra app.
    def master_with_autoconnect
      unless @master
        self.master = Mongo::Connection.new(@sinatra_app.mongo_host, @sinatra_app.mongo_port).db(@sinatra_app.mongo_db)
        @master.authenticate(@sinatra_app.mongo_user, @sinatra_app.mongo_password) if @sinatra_app.mongo_user
      end
      master_without_autoconnect
    end
    
    alias_method :master_without_autoconnect, :master
    alias_method :master, :master_with_autoconnect
    
  end
end



module Sinatra
  module MongoidConfig
    
    def self.registered app
      Mongoid.configure.sinatra_app = app
      
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
