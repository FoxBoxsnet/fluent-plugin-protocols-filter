# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "fluent-plugin-filter-protocols"
  spec.version       = "0.0.6"
  spec.authors       = ["Tokyo Home SOC"]
  spec.email         = ["github@homesoc.tokyo"]

  spec.summary       = %q{Converts the protocol name protocol number.}
  spec.description   = %q{Converts the protocol name protocol number.}
  spec.homepage      = "https://github.com/airforon/fluent-plugin-filter-protocols"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_runtime_dependency 'fluentd', '>= 0.12.00'

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
