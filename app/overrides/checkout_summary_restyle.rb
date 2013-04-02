Deface::Override.new(
  virtual_path: "spree/checkout/edit",
  name: "checkout_summary_restyle",
  surround: "[data-hook='checkout_summary_box'] *",
  text: "<div id='checkout_summary_plate'><%= render_original %></div>"
)