require 'devise'

require "devise_mailchimp/version"

module DeviseMailchimp
  class Engine < Rails::Engine
  end
  # Your code goes here...
end

module Devise
  # Public: Default mailing list for user to join.  This can be an array of strings, or just one string.
  # By default, this is "Site List".  If this will be configurable for each user, override
  # mailchimp_lists_to_join returning the list name or an array of list names for the user to
  # join.
  # Set mailing_list_name in the Devise configuration file (config/initializers/devise.rb)
  #
  #   Devise.mailing_list_name = "Your Mailing List Name"
  mattr_accessor :mailing_list_name
  @@mailing_list_name = "Newsletter"

  # Public: Determines if the checkbox for the user to opt-in to the mailing list should
  # be checked by default, or not.  Defaults to true.
  # Set mailing_list_opt_in_by_default in the Devise configuration file (config/initializers/devise.rb)
  #
  #   Devise.mailing_list_opt_in_by_default = false
  mattr_accessor :mailing_list_opt_in_by_default
  @@mailing_list_opt_in_by_default = true

  # Public: The API key for accessing the mailchimp service.  To generate a new API key, go to the
  # account tab in your MailChimp account and select API Keys & Authorized Apps, then add
  # a key.  This defaults to 'your_api_key'
  # Set mailchimp_api_key in the Devise configuration file (config/initializers/devise.rb)
  #
  #   Devise.mailchimp_api_key = "your_api_key"
  mattr_accessor :mailchimp_api_key
  @@mailchimp_api_key = 'your_api_key'

  # Public: Require double opt-in
  # Requires user to click a link in a confirmation email to be added to the mailing list.  Defaults
  # to false.
  #
  #   Devise.double_opt_in = false
  mattr_accessor :double_opt_in
  @@double_opt_in = false

  # Public: Send welcome email
  # Sends the final 'Welcome Email'. Defaults to false.
  #
  #   Devise.send_welcome_email = false
  mattr_accessor :send_welcome_email
  @@send_welcome_email = false  

end

Devise.add_module :mailchimp, :model => 'devise_mailchimp/model'

require 'devise_mailchimp/mailchimp_list_api_mapper'
