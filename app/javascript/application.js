// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
import "trix";
import "@rails/actiontext";


//= require jquery
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

$(document).on("turbolinks:load", function () {
  $(".alert")
    .delay(2000)
    .slideUp(500, function () {
      $(".alert").alert("close");
    });
});
// Show textarea after clicking the reply button in post comments
document.querySelectorAll(".comment-form-display").forEach((el) => {
  el.addEventListener("click", (ev) => {
    ev.preventDefault();
    el.nextElementSibling.style = "display: block;";
  });
});
