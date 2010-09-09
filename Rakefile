require 'rubygems'
require 'rake'

require File.dirname(__FILE__) + "/lib/everbox/version.rb"

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "everbox"
    gem.version = EverBox::VERSION
    gem.summary = %Q{EverBox Ruby SDK}
    gem.description = %Q{SDK written in Ruby for the EverBox(see http://www.everbox.com).}
    gem.email = "why404@gmail.com"
    gem.homepage = "http://github.com/why404/everbox"
    gem.authors = ["why404"]
    gem.add_development_dependency "rspec", ">= 1.2.9"
    gem.add_dependency "rest-client", ">= 1.6.1.a"
    gem.add_dependency "json_pure", ">= 1.4.6"
    gem.add_dependency "mime-types", ">= 1.16"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

=begin
require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "everbox #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
=end
