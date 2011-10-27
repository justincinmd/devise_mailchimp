# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "devise_mailchimp/version"

Gem::Specification.new do |s|
  s.name        = "devise_mailchimp"
  s.version     = DeviseMailchimp::VERSION
  s.authors     = ["Justin Cunningham"]
  s.email       = ["justin@compucatedsolutions.com"]
  s.homepage    = "http://jcnnghm.github.com/devise_mailchimp/"
  s.summary     = %q{Easy MailChimp integration for Devise}
  s.description = %q{Devise MailChimp adds a MailChimp option to devise that easily enables users to join your mailing list when they create an account.}

  s.rubyforge_project = "devise_mailchimp"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  {
    'rails'  => ['>= 3.0.0', '< 3.2'],
    'devise' => '~> 1.4.8',
    'hominid' => "~> 3.0.2"
  }.each do |lib, version|
    s.add_runtime_dependency(lib, *version)
  end

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
