module Spree
  class PickpointPostamat < PickpointResource

    self.collection_name = 'postamatlist'
    # attr_accessible :title, :body
    
    def self.get_formatted
      prices = PickpointRegion.prices
      postamats = []
      self.all.each do |p|
        if p.Status == 2 && prices.has_key?(p.Region)
          postamats << {
            num: p.Number,
            lat: p.Latitude,
            lng: p.Longitude,
            type: p.TypeTitle,
            in: p.InDescription,
            out: p.OutDescription,
            city: p.CitiName,
            addr: p.Address,
            cash: p.Cash,
            card: p.Card,
            metro: p.Metro,
            name: p.Name,
            sched: p.WorkTime,
            delivery_price: prices[p.Region]
          }
        end
      end
      postamats
    end
  end
end