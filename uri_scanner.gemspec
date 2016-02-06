# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'uri_scanner/version'

Gem::Specification.new do |spec|
  spec.name          = "uri_scanner"
  spec.version       = URIScanner::VERSION
  spec.authors       = ["Stas Kobzar"]
  spec.email         = ["stas@modulis.ca"]
  spec.summary       = %q{URI Parser with Ragel}
  spec.description   = %q{Parsing URI and tokenize URI segments. Scan input text and extract URIs to array. Based on Ragel FSM compiler.}
  spec.homepage      = "https://github.com/staskobzar/uri_scanner"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.5"
end
