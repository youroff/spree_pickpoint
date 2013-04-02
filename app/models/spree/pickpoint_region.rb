module Spree
  class PickpointRegion < ActiveRecord::Base
    attr_accessible :price, :name
    
    validates_uniqueness_of :name
    
    scope :priced, where('price > 0')
    
    def self.sync(regions)
      regions.each do |region|
        self.find_or_create_by_name(region)
      end
    end
    
    def self.prices
      price_sheet = {}
      self.priced.each do |region|
        price_sheet[region.name] = region.price
      end
      price_sheet
    end
    
  end
end
