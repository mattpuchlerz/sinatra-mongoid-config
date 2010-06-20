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

This extension works fine with both "classic" Sinatra apps, as well as "modular" apps which inherit from `Sinatra::Base`. How you use the extension varies slightly between styles.

### "Classic"

    require 'rubygems'
    require 'sinatra'
    require 'sinatra-mongoid-config'
    
    get '/' do
      'It works!'
    end

### "Modular"

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

All options are set using Sinatra's standard `set` method. Remember that you can also change settings for each environment:

    configure do
      set :mongo_db, 'the_database'
      set :mongo_port, 123
    end

    configure :production do
      set :mongo_db, 'the_other_database'
      set :mongo_user, 'the_user'
      set :mongo_password, 'the_password'
    end
    
All configuration options have **sensible defaults listed below**, and depending on your situation, you may not have to set anything. 

<table>
  <thead>
    <tr>
      <th style="text-align: left">Option</th>
      <th style="text-align: left">Default</th>
    </tr>
  </thead>
  <tbody>
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

Did you notice the call to `self.app_to_db_name`? That method attempts to be smart about what your database is named, based on **the class name of your app and the current environment**. The real benefit here is for those who are creating "modular" apps, as they are named something other than the Sinatra default. Here are some examples:

<table>
  <thead>
    <tr>
      <th style="text-align: left">App&rsquo;s Class Name</th>
      <th style="text-align: left">Environment</th>
      <th style="text-align: left">Resulting Database Name</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>Refresh</code></td>
      <td><code>:development</code></td>
      <td><code>refresh_development</code></td>
    </tr>
    <tr>
      <td><code>RefreshChicago</code></td>
      <td><code>:test</code></td>
      <td><code>refresh_chicago_test</code></td>
    </tr>
    <tr>
      <td><code>RefreshChicago::Jobs</code></td>
      <td><code>:production</code></td>
      <td><code>refresh_chicago_jobs_production</code></td>
    </tr>
    <tr>
      <td><code>Sinatra::Application</code></td>
      <td><code>:development</code></td>
      <td><code>sinatra_application_development</code></td>
    </tr>
  </tbody>
</table>

Alternatives
------------

* Dan Croak's [sinatra-mongoid](http://github.com/dancroak/sinatra-mongoid)
* Ethan Gunderson's [sinatra-mongo-config](http://github.com/ethangunderson/sinatra-mongo-config)


