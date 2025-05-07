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


// Show more button
document.addEventListener("turbo:load", () => {
  const shortDesc = document.getElementById("short-description");
  const fullDesc = document.getElementById("full-description");
  const toggleBtn = document.getElementById("toggle-description");

  if (shortDesc && fullDesc && toggleBtn) {
    toggleBtn.addEventListener("click", () => {
      const isHidden = fullDesc.style.display === "none" || fullDesc.style.display === "";
      fullDesc.style.display = isHidden ? "block" : "none";
      shortDesc.style.display = isHidden ? "none" : "block";
      toggleBtn.textContent = isHidden ? "Show less" : "Show more";
    });
  }
});
