# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'termpic/version'

Gem::Specification.new do |gem|
  gem.name          = "termpic"
  gem.version       = Termpic::VERSION
  gem.authors       = ["onk"]
  gem.email         = ["takafumi.onaka@gmail.com"]
  gem.description   = "Display images in terminal."
  gem.summary       = "Display images in terminal."
  gem.homepage      = "https://github.com/onk/termpic"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rake"
end
