require File.join([File.dirname(__FILE__), 'lib', 'freckle_api', 'version.rb'])

Gem::Specification.new do |s|
  s.name = 'freckle-api'
  s.version = FreckleApi::VERSION
  s.license = 'MIT'
  s.summary = "Client for Freckle's API V2."
  s.author = 'Jamie Schembri'
  s.email = 'jamie@schembri.me'
  s.homepage = 'http://github.com/shkm/freckle-api'
  s.platform = Gem::Platform::RUBY

  s.files = Dir['LICENSE', 'README.md', 'lib/**/*.rb']
  s.test_files = Dir['spec/**/*.rb']

  s.add_development_dependency('rake')
  s.add_development_dependency('rspec')
  s.add_development_dependency('webmock')
  s.add_development_dependency('pry-byebug')
  s.add_development_dependency('sinatra')
  s.add_development_dependency('sinatra-contrib')
  s.add_runtime_dependency('hashie')
  s.add_runtime_dependency('httparty')
end
