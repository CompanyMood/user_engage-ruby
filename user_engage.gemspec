# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'user_engage/version'

Gem::Specification.new do |spec|
  spec.name          = 'user_engage'
  spec.version       = UserEngage::VERSION
  spec.authors       = ['Markus Schwed']
  spec.email         = ['markus@company-mood.com']

  spec.summary       = 'NOT READY YET!! - Ruby bindings for the UserEngage API'
  spec.description   = 'UserEngage (https://userengage.com) - '\
    'Keep things simple with a single platform '\
    'for all your messaging and relationships with customers.'
  spec.homepage      = 'https://github.com/CompanyMood/user_engage-ruby'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'dry-struct', '~> 0.5'
  spec.add_runtime_dependency 'faraday', '>= 0.12'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'dotenv', '~> 2.2'
  spec.add_development_dependency 'pry', '~> 0.11.3'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.59'
  spec.add_development_dependency 'vcr', '~> 4.0'
  spec.add_development_dependency 'webmock', '~> 3.3'
end
