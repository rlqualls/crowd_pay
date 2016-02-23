require File.expand_path('../lib/crowd_pay/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = 'crowd_pay'
  gem.version     = CrowdPay::VERSION
  gem.date        = '2016-02-23'
  gem.summary     =
  gem.description = 'CrowdPay.com API wrapper for Ruby'
  gem.authors     = ['Kelton Manzanares', 'Prakash Lingaiah']
  gem.email       = ['kelton.manzanares@gmail.com', 'plingaiah@qwinix.io ']
  gem.files       = ['lib/crowd_pay.rb']
  gem.homepage    = 'https://github.com/qwinix/crowd_pay'
  gem.license     = 'MIT'
end
