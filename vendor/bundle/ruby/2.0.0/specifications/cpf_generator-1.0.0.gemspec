# -*- encoding: utf-8 -*-
# stub: cpf_generator 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "cpf_generator"
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Jose Carlos Ustra Junior"]
  s.date = "2013-09-25"
  s.description = "Gerador de cpf para testes"
  s.email = ["dev@ustrajunior.com"]
  s.homepage = "https://github.com/ustrajunior/cpf_generator"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.2"
  s.summary = "Gerador de cpf para ser usados para testes"

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.3"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.13.0"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.3"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.13.0"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.3"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.13.0"])
  end
end
