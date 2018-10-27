$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'soql_builder/version'

Gem::Specification.new do |s|
  s.name        = 'soql_builder'
  s.version     = SoqlBuilder::VERSION
  s.date        = '2018-10-27'
  s.summary     = 'Ruby SOQL Builder'
  s.description = 'A ruby tool to build SOQL queries'
  s.authors     = ['Alex Avlonitis']
  s.files       = ['lib/soql_builder.rb']
  s.homepage    = 'https://github.com/AlexAvlonitis/soql-builder'
  s.license     = 'MIT'

  s.add_development_dependency 'rspec'
end
