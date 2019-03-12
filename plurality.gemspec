# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'plurality/version'

Gem::Specification.new do |spec|
  spec.name          = "plurality"
  spec.version       = Plurality::VERSION
  spec.authors       = ["Evan Alter"]
  spec.email         = ["evan.alter@gmail.com"]
  spec.description   = %q{Pluralize sentences based on the number of objects}
  spec.summary       = %q{Sentence pluralization}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "i18n", ">= 0.7.0", "< 2"
  spec.add_dependency "numbers_and_words", "~> 0.11.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14"
end
