source 'https://rubygems.org'

group :rake, :test do
  gem 'puppetlabs_spec_helper', '>=0.8.2', :require => false
  gem 'rspec-puppet-augeas', '>=0.4.0', :require => false
end

group :rake do
  gem 'rspec-puppet', '>=2.1.0', :require => false
  gem 'rake',         '>=0.9.2.2'
  gem 'puppet-lint',  '>=1.0.1'
end

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', :require => false
end

