module Mongoid
	module Config extend self
	  
	  option :sinatra_app	  

    # If the database connection doesn't already exist,
    # attempt to connect using options from the Sinatra app.
    def master_with_autoconnect
      @app = settings[:sinatra_app]
      unless @master
        self.master = Mongo::Connection.new(@app.mongo_host, @app.mongo_port).db(@app.mongo_db)
        @master.authenticate(@app.mongo_user, @app.mongo_password) if @app.mongo_user
      end
      master_without_autoconnect
    end
    
    alias_method :master_without_autoconnect, :master
    alias_method :master, :master_with_autoconnect
	
	end
end