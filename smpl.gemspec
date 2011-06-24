# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "smpl/version"

Gem::Specification.new do |s|
  s.name        = "smpl"
  s.version     = SMPL::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["TODO: Write your name"]
  s.email       = ["TODO: Write your email address"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "smpl"
  
  s.add_dependency              'rack',               '~> 1.3.0'
  s.add_dependency              'sinatra-synchrony',  '~> 0.0.3'
  s.add_development_dependency  'rspec',              '~> 2.6.0'
  s.add_development_dependency  'rack-test',          '~> 0.6.0'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
