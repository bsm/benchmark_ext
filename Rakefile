require "rake"
require "rake/clean"
require 'rake/extensiontask'
require 'rbconfig'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)
Rake::ExtensionTask.new('benchmark_ext')

desc 'Default: compile and run specs.'
task :default => [:compile, :spec]
