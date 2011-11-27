Gem::Specification.new do |s|
  s.name    = "sinatra-mongoid-config"
  s.version = "0.1.2"

  s.authors     = [ "Matt Puchlerz" ]
  s.date        = "2010-06-19"
  s.description = "Add Monogid to your Sinatra app with potentially zero-configuration. Lazily creates the database connection whenever needed."
  s.email       = "matt@puchlerz.com"
  s.homepage    = "http://github.com/mattpuchlerz/sinatra-mongoid-config"
  s.summary     = "Easy Mongoid config for Sinatra."

  s.files  = %w[ README.md ]
  s.files += Dir["lib/**/*"]

  s.add_runtime_dependency "sinatra", "~> 1.3.1" 
  s.add_runtime_dependency "mongoid", "~> 2.3.4" 
end