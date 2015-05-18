# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cpf_generator/version'

Gem::Specification.new do |spec|
  spec.name          = "cpf_generator"
  spec.version       = CpfGenerator::VERSION
  spec.authors       = ["Jose Carlos Ustra Junior"]
  spec.email         = ["dev@ustrajunior.com"]
  spec.description   = %q{Gerador de cpf para testes}
  spec.summary       = %q{Gerador de cpf para ser usados para testes}
  spec.homepage      = "https://github.com/ustrajunior/cpf_generator"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.13.0"
end
