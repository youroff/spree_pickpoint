#coding: UTF-8
module Spree
  class Pickpoint < ActiveRecord::Base
    attr_accessible :addr, :card, :cash, :city, :region, :in, :lat, :lng, :metro, :name, :num, :out, :ptype, :sched, :status
    
    scope :active, where(:verified => true, :status => 2)
    scope :priced, includes(:price).joins(:price).where('spree_pickpoint_regions.price > 0')
    
    belongs_to :price, :class_name => "Spree::PickpointRegion", :foreign_key => :region, :primary_key => :name, :select => [:name, :price]
    
    def self.sync!
      self.update_all(:verified => false)
      PickpointPostamat.all.each do |p|
        postamat_data = {
          lat: p.Latitude,
          lng: p.Longitude,
          ptype: p.TypeTitle.to_url,
          in: p.InDescription,
          out: p.OutDescription,
          city: p.CitiName,
          region: p.Region,
          addr: p.Address,
          cash: p.Cash,
          card: p.Card,
          metro: p.Metro,
          name: p.Name,
          sched: p.WorkTime,
          status: p.Status
        }
        postamat = self.find_or_create_by_num(p.Number)
        postamat.update_attributes(postamat_data)
        postamat.verified = true
        postamat.save()
      end
    end
    
    def self.coordinates
      ActiveRecord::Base.include_root_in_json = false
      self.active.priced.to_json(
        :only => [:id, :lat, :lng, :ptype]
      )
    end
    
    def delivery_price
      @delivery_price ||= price.price || 0
    end
    
    def payment_opts
      opts = []
      opts << "наличные" if cash
      opts << "банковские карты" if card
      opts
    end
  end
end
