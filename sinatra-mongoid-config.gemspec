Gem::Specification.new do |s|
  s.name    = "sinatra-mongoid-config"
  s.version = "0.1.0"

  s.authors     = [ "Matt Puchlerz" ]
  s.date        = "2010-06-19"
  s.description = "Easy configuration when using Mongoid within a Sinatra app. Lazily creates the database connection when called upon."
  s.email       = "matt@puchlerz.com"
  s.homepage    = "http://github.com/mattpuchlerz/sinatra-mongoid-config"
  s.summary     = "Mongoid config for Sinatra."

  s.files  = %w[ README.md ]
  s.files += Dir["lib/**/*"]

  s.add_dependency "sinatra", [ ">= 1.0" ]
  s.add_dependency "mongoid", [ ">= 2.0.0.beta7" ]
end