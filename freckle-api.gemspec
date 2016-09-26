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
  s.required_ruby_version = '>= 2.2.0'

  s.files = Dir['LICENSE', 'README.md', 'lib/**/*.rb']
  s.test_files = Dir['spec/**/*.rb']

  s.add_development_dependency('rake', '~> 10.1')
  s.add_development_dependency('rspec', '~> 3.4')
  s.add_development_dependency('webmock', '~> 1.22')
  s.add_development_dependency('pry-byebug', '~> 3.3')
  s.add_development_dependency('codeclimate-test-reporter', '>= 0.4')
  s.add_runtime_dependency('hashie', '~> 3.4')
end
