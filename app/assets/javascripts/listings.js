document.addEventListener("turbolinks:load", function() {
  document.querySelector("#listing_click").addEventListener("click", function(e) {
    ahoy.track("Listing Clicked", e.target.dataset)
  });
});
