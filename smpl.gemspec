# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "smpl/version"

Gem::Specification.new do |s|
  s.name        = "smpl"
  s.version     = SMPL::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Adam Zaninovich"]
  s.email       = ["adam.zaninovich@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Simple TCP server with web front-end}
  s.description = %q{EventMachine-backed TCPserver accepts connections and displays them on a sinatra-based web interface}

  s.rubyforge_project = "smpl"
  
  s.add_dependency              'rack',               '~> 1.3.0'
  s.add_dependency              'rack-coffee',        '~> 0.9.1'
  s.add_dependency              'faye',               '~> 0.6.2'
  s.add_dependency              'sinatra-synchrony',  '~> 0.0.3'
  s.add_dependency              'sass',               '~> 3.1.3'
  s.add_development_dependency  'rack-test',          '~> 0.6.0'
  s.add_development_dependency  'rspec',              '~> 2.6.0'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
