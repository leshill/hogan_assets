# -*- encoding: utf-8 -*-
require File.expand_path('../lib/hogan_assets/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Les Hill"]
  gem.email         = ["leshill@gmail.com"]
  gem.description   = %q{Use compiled hogan.js (mustache) JavaScript templates with sprockets and the Rails asset pipeline.}
  gem.summary       = %q{Use compiled hogan.js (mustache) JavaScript templates with sprockets and the Rails asset pipeline.}
  gem.homepage      = "https://github.com/leshill/hogan_assets"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "hogan_assets"
  gem.require_paths = ["lib"]
  gem.version       = HoganAssets::VERSION

  gem.add_runtime_dependency "execjs", ">= 1.2.9"
  gem.add_runtime_dependency "tilt", ">= 1.3.3"
  gem.add_runtime_dependency "sprockets", ">= 2.0.3"

  gem.add_development_dependency "haml"
  gem.add_development_dependency "slim"
end
