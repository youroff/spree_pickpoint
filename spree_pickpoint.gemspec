# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_pickpoint'
  s.version     = '0.0.2'
  s.summary     = 'Spree Pickpoint delivery (experimental)'
  s.description = 'Pickpoint support for Spree, '
  s.required_ruby_version = '>= 1.9.3'

  s.author    = 'Ivan Youroff'
  s.email     = 'ivan.youroff@gmail.com'
  # s.homepage  = 'http://www.spreecommerce.com'

  #s.files       = `git ls-files`.split("\n")
  #s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 1.3'
  s.add_dependency 'eco'
  s.add_dependency 'rabl', '~> 0.7'
  # 
  # 
  # s.add_development_dependency 'capybara', '1.0.1'
  # s.add_development_dependency 'factory_girl', '~> 2.6.4'
  # s.add_development_dependency 'ffaker'
  # s.add_development_dependency 'rspec-rails',  '~> 2.9'
  # s.add_development_dependency 'sqlite3'
end
