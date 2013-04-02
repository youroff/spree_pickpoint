object @pickpoint
attributes :num, :name, :in, :out, :metro, :cash, :card, :sched, :lat, :lng, :ptype

node(:delivery_price) {|object| object.delivery_price}
node(:addr) {|o| o.city + ', ' + o.addr }