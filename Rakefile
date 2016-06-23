require 'rake'
require 'puppetlabs_spec_helper/rake_tasks'

# SPEC_SUITES = (Dir.entries('spec') - ['.', '..','fixtures']).select {|e| File.directory? "spec/#{e}" }
task :default => :spec

begin
  if Gem::Specification::find_by_name('puppet-lint')
    require 'puppet-lint/tasks/puppet-lint'
    Rake::Task[:lint].clear
    PuppetLint::RakeTask.new :lint do |config|
      config.ignore_paths = ["spec/**/*.pp", "vendor/**/*.pp", "vendor/**/*.rb"]
      config.log_format = '%{path}:%{linenumber}:%{KIND}: %{message}'
      config.disable_checks = [ "class_inherits_from_params_class", "80chars" ]
    end
    task :default => [:rspec, :lint]
  end
rescue Gem::LoadError
end

begin
  require 'kitchen/rake_tasks'
  Kitchen::RakeTasks.new
rescue LoadError
  puts '>>>>> Kitchen gem not loaded, omitting tasks' unless ENV['CI']
end
