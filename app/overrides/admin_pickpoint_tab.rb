Deface::Override.new(:virtual_path => "spree/layouts/admin",
                     :name => "pickpoint_admin_tabs",
                     :insert_bottom => "[data-hook='admin_tabs'], #admin_tabs[data-hook]",
                     :text => "<%= tab(:pickpoint_admin, :url => spree.admin_pickpoint_regions_path) %>",
                     :disabled => false,
                     :original => '3e847740dc3e7f924aba1ccb4cb00c7b841649e3')