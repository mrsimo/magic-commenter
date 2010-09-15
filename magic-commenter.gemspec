# -*- encoding: utf-8 -*-
require File.expand_path("../lib/magic-commenter/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "magic-commenter"
  s.version     = Magic::Commenter::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = []
  s.email       = []
  s.summary     = "TODO: Write a gem summary"
  s.description = "TODO: Write a gem description"

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "magic-commenter"

  s.add_development_dependency "bundler", ">= 1.0.0"

  s.files        = `git ls-files`.split("\n")
  s.executables  = ["magic-commenter"]
  s.require_path = 'lib'
end
