module Mongoid
	module Config extend self
	  
	  option :sinatra_app	  

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