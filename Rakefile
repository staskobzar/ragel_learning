require 'rake'
require 'mkmf'
require 'rspec/core/rake_task'
require "bundler/gem_tasks"

RSpec::Core::RakeTask.new(:spec)

task :default do
  Rake::Task['ragel'].invoke
  Rake::Task['spec'].invoke
end

desc "Build ragel machines into ruby classes."
task :ragel do
  ragel = find_executable('ragel')
  raise ArgumentError, "Ragel executable not found" unless ragel
  Dir["lib/uri_scanner/*.rl"].each do |file|
    sh "#{ragel} -R #{file}"
  end
end

desc "Create transition graphs."
task :graph do
  format = "svg"
  ragel = find_executable('ragel')
  raise ArgumentError, "Ragel executable not found" unless ragel
  dot = find_executable('dot')
  raise ArgumentError, "Graphviz executable not found" unless dot
  Dir["lib/uri_scanner/*.rl"].each do |file|
    sh "#{ragel} -R #{file}"
    sh "#{ragel} -Vp #{file} -o #{file}.dot" 
    sh "#{dot} #{file}.dot -T#{format} -o #{file}.#{format}"
    sh "rm #{file}.dot"
  end
end
