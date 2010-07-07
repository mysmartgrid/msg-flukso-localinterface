require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "msg-flukso-localinterface"
    gem.summary = %Q{Displays various information from the mySmartGrid project on your Chumby}
    gem.description = %Q{The mySmartGrid project provides means to manage your household energy consumption. This gem provides the runtime environment for the Chumby: it queries the mySmartGrid webservice and forwards that information to a Flash application running on the Chumby.}
    gem.email = "md@gonium.net"
    gem.homepage = "http://github.com/gonium/msg-flukso-localinterface"
    gem.authors = ["Mathias Dalheimer"]
    gem.add_dependency "xml-simple", ">= 1.0.12"
    gem.bindir='bin'
    gem.executables=['msg-flukso-discover', 'msg-flukso-query']
    gem.default_executable = 'msg-discover-flukso'
    gem.files = FileList["[A-Z]*", "{bin,lib,test}/**/*"]
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "msg-chumby-display #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
