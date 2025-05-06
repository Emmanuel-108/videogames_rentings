// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"


document.addEventListener("turbo:load", () => {
  const filterButton = document.querySelector(".buttonfilter");
  const filterPanel = document.getElementById("filter-panel");

  if (filterButton && filterPanel) {
    filterButton.addEventListener("click", () => {
      filterPanel.classList.toggle("hidden");
    });
  }
});
