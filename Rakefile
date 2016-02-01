require 'rake'
require 'mkmf'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default do
  Rake::Task['ragel'].invoke
  Rake::Task['spec'].invoke
end

desc "Build ragel machines into ruby classes."
task :ragel do
  ragel = find_executable('ragel')
  raise ArgumentError, "Ragel executable not found" unless ragel
  Dir["lib/*.rl"].each do |file|
    sh "#{ragel} -R #{file}"
  end
end
