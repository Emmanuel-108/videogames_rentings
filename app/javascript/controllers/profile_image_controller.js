import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="profile-image"
export default class extends Controller {
  static targets = ["imageElement", "fileInput"]

  connect() {
    // console.log("Profile image Stimulus controller connected.")
  }

  upload(event) {
    // console.log(this.imageElementTarget)
    event.preventDefault();
    this.fileInputTarget.click();
  }

  fileChanged() {
    this.fileInputTarget.closest("form").submit();
  }
}
