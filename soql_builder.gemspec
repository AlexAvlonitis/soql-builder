lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

require 'soql/version'

Gem::Specification.new do |s|
  s.name        = 'soql_builder'
  s.version     = Soql::VERSION
  s.date        = '2018-10-27'
  s.summary     = 'Ruby SOQL Builder'
  s.description = 'A ruby tool to build SOQL queries'
  s.authors     = ['Alex Avlonitis']
  s.files       = Dir.glob('{bin,lib}/**/*') + %w[README.md]
  s.homepage    = 'https://github.com/AlexAvlonitis/soql-builder'
  s.license     = 'MIT'

  s.add_development_dependency 'rspec'
end
