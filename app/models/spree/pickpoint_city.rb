module Spree
  class PickpointCity < PickpointResource
    self.collection_name = 'citylist'
    
    def self.regions
      regions = []
      self.all.each do |city|
        regions << city.RegionName
      end
      regions.uniq!.sort!      
    end
  end
end
