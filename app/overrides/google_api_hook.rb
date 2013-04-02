Deface::Override.new(
  virtual_path: "spree/layouts/spree_application",
  name: "google_api_hook",
  insert_top: "[data-hook='inside_head']",
  text: "<% content_for :head do %>
          <script type='text/javascript' src='http://maps.googleapis.com/maps/api/js?key=AIzaSyDKBDsYDP2DVa7WDvGWNXdfvwsRt_erX5I&sensor=false'></script>
         <% end %>"
)