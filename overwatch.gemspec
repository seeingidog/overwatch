# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "overwatch/version"

Gem::Specification.new do |s|
  s.name        = "overwatch"
  s.version     = Overwatch::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["TODO: Write your name"]
  s.email       = ["TODO: Write your email address"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "overwatch"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency("hiredis", "~> 0.3.1")
  s.add_dependency("redis", "~> 2.2.0")
  s.add_dependency("sinatra", "~> 1.2.1")
  s.add_dependency("ohm", "~> 0.1.3")
  s.add_dependency("ohm-contrib", "~> 0.1.1")
  s.add_dependency("nest", "~> 1.1.0")
  s.add_dependency("vegas", "~> 0.1.8")
end