sinatra-mongoid-config
======================

Easy configuration when using Mongoid within a Sinatra app. Lazily creates the database connection when called upon.

Installation
------------

It's available as a gem via RubyGems.org, so use standard procedure:

    $ gem install sinatra-mongoid-config
  
If you're using Bundler, just add `gem "sinatra-mongoid-config"` to your `Gemfile`.

Using the Extension
-------------------

As with all Sinatra extensions, it's simply a matter of **requiring the library** and **registering the extension**. Other than that, you should just **set the database name**.

    require 'sinatra'
    require 'sinatra-mongoid-config'
    
    register Sinatra::MongoidConfig
    
    configure do
      set :mongo_db, 'the_database_name'
    end
    
    get '/' do
      'It works!'
    end
    
Note that this extension works fine both with classic-style Sinatra apps like the one above, as well as modular-style apps which inherit from `Sinatra::Base`.

### Options

    app.set :mongo_host,     ENV['MONGO_HOST'] || 'localhost'
    app.set :mongo_db,       ENV['MONGO_DB']   || 'sinatra-mongoid'
    app.set :mongo_port,     ENV['MONGO_PORT'] || Mongo::Connection::DEFAULT_PORT
    app.set :mongo_user,     ENV['MONGO_USER']
    app.set :mongo_password, ENV['MONGO_PASSWORD']

All configuration options have **sensible defaults listed above**, and in most cases, you can get away with just setting the `:mongo_db`. Remember that you can also change settings for each environment:

    configure do
      set :mongo_db, 'the_database_development'
    end

    configure :test do
      set :mongo_db, 'the_database_test'
    end

    configure :production do
      set :mongo_db, 'the_database_production'
    end
    
Alternatives
------------

* Dan Croak's [sinatra-mongoid](http://github.com/dancroak/sinatra-mongoid)
* Ethan Gunderson's [sinatra-mongo-config](http://github.com/ethangunderson/sinatra-mongo-config)


