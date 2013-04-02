module SpreePickpoint
  class Engine < Rails::Engine
    require 'spree/core'
    require 'rabl'
    isolate_namespace Spree
    engine_name 'spree_pickpoint'

    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += %W(#{config.root}/app/overrides)

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end
    
    initializer 'spree.pickpoint.preferences', :after => "spree.environment" do |app|
      Spree::PickpointConfiguration = Spree::SpreePickpointConfiguration.new
    end
    
    initializer 'spree.register.rabl' do |app|
      Rabl.configure do |config|
        config.include_json_root = false
      end
    end
    
    initializer "spree_pickpoint.register.payment_methods" do |app|
      app.config.spree.payment_methods << Spree::PaymentMethod::Pickpoint
    end
    
    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
