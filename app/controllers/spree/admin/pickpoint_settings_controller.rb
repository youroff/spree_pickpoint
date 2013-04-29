module Spree
  module Admin
    class PickpointSettingsController < Spree::Admin::BaseController
      def show
        @preferences_pickpoint = [:test_mode, :login, :password, :ikn]
      end

      def edit
        @preferences = [:test_mode]
      end

      def update
        params.each do |name, value|
          next unless Spree::PickpointConfiguration.has_preference? name
          Spree::PickpointConfiguration[name] = value
        end

        redirect_to admin_pickpoint_settings_path
      end
    end
  end
end