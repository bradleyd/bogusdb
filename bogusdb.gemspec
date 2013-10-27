# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bogusdb/version'

Gem::Specification.new do |spec|
  spec.name          = "bogusdb"
  spec.version       = Bogusdb::VERSION
  spec.authors       = ["Bradley Smith"]
  spec.email         = ["bradleydsmith@gmail.com"]
  spec.description   = %q{ A simple fake database object for testing }
  spec.summary       = %q{A simple fake ORM databsase object used in testing}
  spec.homepage      = "http://github.com:bradleyd/bogusdb.git"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "mocha"
end
