require "bundler/gem_tasks"

desc "push the gem to a gemserver"
task :pushgem do
  built_gem_path = Dir[File.join("pkg/sinatra-mongoid-config-*.gem")].sort_by{|f| File.mtime(f)}.last
  %x[bundle exec gem inabox #{built_gem_path} --host #{ENV["GEM_HOST"]}]
end
