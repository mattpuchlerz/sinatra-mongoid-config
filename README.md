sinatra-mongoid-config
======================

Add Monogid to your Sinatra app with potentially zero-configuration. Lazily create the database connection whenever needed.

Installation
------------

It&lsquo;s available as a gem via RubyGems.org, so use standard procedure:

    $ gem install sinatra-mongoid-config
  
If you're using Bundler, just add `gem "sinatra-mongoid-config"` to your `Gemfile`.

Using the Extension
-------------------

This extension works fine with both &ldquo;classic&rdquo; Sinatra apps, as well as &ldquo;modular&rdquo; apps which inherit from `Sinatra::Base`. How you use the extension varies slightly between styles.

### &ldquo;Classic&rdquo;

    require 'rubygems'
    require 'sinatra'
    require 'sinatra-mongoid-config'
    
    get '/' do
      'It works!'
    end

### &ldquo;Modular&rdquo;

    require 'rubygems'
    require 'sinatra'
    require 'sinatra-mongoid-config'
    
    class MyApp < Sinatra::Base
    
      register Sinatra::MongoidConfig
    
      get '/' do
        'It works!'
      end
    
    end
    
Options & Defaults
------------------

All options are set using Sinatra&rsquo;s standard `set` method. Remember that you can also change settings for each environment:

    configure do
      set :mongo_db, 'the_database'
      set :mongo_port, 123
    end

    configure :production do
      set :mongo_db, 'the_other_database'
      set :mongo_user, 'the_user'
      set :mongo_password, 'the_password'
    end

Optionally, you can use the full MongoDB URI (i.e. on Heroku):

    # ENV['MONGOHQ_URL'] # => "mongodb://USER:PASS@HOST:PORT/DB"
    configure :production do
      set :mongo_uri, ENV['MONGOHQ_URL']
    end

### Defaults
    
All configuration options have **sensible defaults listed below**, and depending on your situation, you may not have to set anything. 

<table>
  <thead>
    <tr>
      <th>Option</th>
      <th>Default</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>:mongo_uri</code></td>
      <td><code>ENV['MONGO_URI']</code></td>
    </tr>
    <tr>
      <td><code>:mongo_host</code></td>
      <td><code>ENV['MONGO_HOST'] || 'localhost'</code></td>
    </tr>
    <tr>
      <td><code>:mongo_db</code></td>
      <td><code>ENV['MONGO_DB']   || self.app_to_db_name(app)</code></td>
    </tr>
    <tr>
      <td><code>:mongo_port</code></td>
      <td><code>ENV['MONGO_PORT'] || Mongo::Connection::DEFAULT_PORT</code></td>
    </tr>
    <tr>
      <td><code>:mongo_user</code></td>
      <td><code>ENV['MONGO_USER']</code></td>
    </tr>
    <tr>
      <td><code>:mongo_password</code></td>
      <td><code>ENV['MONGO_PASSWORD']</code></td>
    </tr>
  </tbody>
</table>

### Default DB Naming Convention

Did you notice that the default for `:mongo_db` calls `self.app_to_db_name`? That method attempts to be smart about what your database is named by using **the class name of your app and the current environment**. The real benefit here is for those who are creating "modular" apps, as they are named something other than the Sinatra default. Here are some examples:

<table>
  <thead>
    <tr>
      <th>App&rsquo;s Class Name</th>
      <th>Environment</th>
      <th>Resulting Database Name</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>Refresh</code></td>
      <td><code>:development</code></td>
      <td><code>'refresh_development'</code></td>
    </tr>
    <tr>
      <td><code>RefreshChicago</code></td>
      <td><code>:test</code></td>
      <td><code>'refresh_chicago_test'</code></td>
    </tr>
    <tr>
      <td><code>RefreshChicago::Jobs</code></td>
      <td><code>:production</code></td>
      <td><code>'refresh_chicago_jobs_production'</code></td>
    </tr>
    <tr>
      <td><code>Sinatra::Application</code></td>
      <td><code>:development</code></td>
      <td><code>'sinatra_application_development'</code></td>
    </tr>
  </tbody>
</table>

Alternatives
------------

* Dan Croak's [sinatra-mongoid](http://github.com/dancroak/sinatra-mongoid)
* Ethan Gunderson's [sinatra-mongo-config](http://github.com/ethangunderson/sinatra-mongo-config)


