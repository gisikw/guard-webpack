# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'guard/webpack/version'

Gem::Specification.new do |spec|
  spec.name          = "guard-webpack"
  spec.version       = Guard::WebpackVersion::VERSION
  spec.authors       = ["Kevin Gisi"]
  spec.email         = ["kevin@kevingisi.com"]
  spec.summary       = %q{Guard plugin for Webpack}
  spec.homepage      = "https://github.com/gisikw/guard-webpack"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'guard',  '< 3.0'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"

end
