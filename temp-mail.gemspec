# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'temp/mail/version'

Gem::Specification.new do |spec|
  spec.name          = 'temp-mail'
  spec.version       = Temp::Mail::VERSION
  spec.authors       = ['Maxim Dobryakov']
  spec.email         = ['maxim.dobryakov@gmail.com']
  spec.summary       = %q{Client to temp-mail.ru API.}
  spec.description   = %q{Ruby client to temp-mail.ru API}
  spec.homepage      = 'https://github.com/maxd/temp-mail'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.2'
end
