Deface::Override.new(
  virtual_path: "spree/checkout/edit",
  name: "checkout_postamat_selector",
  insert_top: "[data-hook='checkout_form_wrapper']",
  text: "<%= render :partial => 'spree/checkout/pickpoint_map' if @order.state == 'pickpoint' %>"
)