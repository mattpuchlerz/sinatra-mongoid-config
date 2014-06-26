Gem::Specification.new do |s|
  s.name    = "sinatra-mongoid-config"
  s.version = "0.1.0"

  s.authors     = [ "Matt Puchlerz" ]
  s.date        = "2010-06-19"
  s.description = "Add Monogid to your Sinatra app with potentially zero-configuration. Lazily creates the database connection whenever needed."
  s.email       = "matt@puchlerz.com"
  s.homepage    = "http://github.com/mattpuchlerz/sinatra-mongoid-config"
  s.summary     = "Easy Mongoid config for Sinatra."

  s.files  = %w[ README.md ]
  s.files += Dir["lib/**/*"]

  s.add_dependency "sinatra", [ ">= 1.0" ]
  s.add_dependency "mongoid", [ ">= 2.0.0.rc" ]
end