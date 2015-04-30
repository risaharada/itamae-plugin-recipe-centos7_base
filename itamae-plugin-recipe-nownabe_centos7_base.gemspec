# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'itamae/plugin/recipe/nownabe_centos7_base/version'

Gem::Specification.new do |spec|
  spec.name          = "itamae-plugin-recipe-nownabe_centos7_base"
  spec.version       = Itamae::Plugin::Recipe::NownabeCentos7Base::VERSION
  spec.authors       = ["nownabe"]
  spec.email         = ["nownabe@gmail.com"]
  spec.summary       = %q{An Itamae plugin: CentOS 7 base}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "itamae", "~> 1.1.1"
  spec.add_dependency "itamae-plugin-resource-ssh_key"
  spec.add_dependency "activesupport"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "serverspec", "~> 2.7.1"
  spec.add_development_dependency "unix-crypt"
  spec.add_development_dependency "webmock"
end
