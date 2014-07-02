require "bundler"

namespace :gem do

  Bundler::GemHelper.install_tasks

  task :server do
    raise "Please set your GEM_SERVER variable" unless ENV['GEM_SERVER']
  end

  desc "Push the latest gem to the server"
  task :push => :server do
    sh "bundle exec gem inabox #{built_gem_path} --host #{ENV['GEM_SERVER']}"
  end

  desc "Delete the latest gem from the server"
  task :delete => :server do
    sh "curl -X DELETE #{ENV['GEM_SERVER']}/gems/#{built_gem_path.gsub('pkg/','')}"
  end

  desc "Update the gem (build, delete and push)"
  task :update => [ :build, :delete, :push ]

  private

  def built_gem_path
    Dir[File.join("pkg/sinatra-mongoid-config--*.gem")].sort_by{|f| File.mtime(f)}.last
  end

end
