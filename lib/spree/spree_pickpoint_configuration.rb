#lib/spree/pickpoint_configuration.rb
module Spree
  class SpreePickpointConfiguration < Preferences::Configuration
    preference :test_mode, :boolean, :default => true
    preference :test_api_url, :string, :default => 'http://e-solution.pickpoint.ru/apitest/'
    preference :test_login, :string, :default => 'apitest'
    preference :test_password, :string, :default => 'apitest'
    preference :test_ikn, :string, :default => '9990003511'
    
    preference :api_url, :string, :default => 'http://e-solution.pickpoint.ru/api/'
    preference :login, :string
    preference :password, :string
    preference :ikn, :string
  end
end