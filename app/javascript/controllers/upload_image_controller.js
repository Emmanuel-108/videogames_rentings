import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="upload-image"
export default class extends Controller {
  static targets = ["photo", "backgroundImage"]

  connect() {
    console.log("upload-image controller connected.")
    this.toggle()
  }

  toggle() {
    const photoFilled = this.photoTarget.files.length > 0
    const backgroundFilled = this.backgroundImageTarget.value.trim() !== ""

    if (photoFilled) {
      this.backgroundImageTarget.disabled = true
      this.backgroundImageTarget.classList.add("disabled-field")
    } else {
      this.backgroundImageTarget.disabled = false
      this.backgroundImageTarget.classList.remove("disabled-field")
    }

    if (backgroundFilled) {
      this.photoTarget.disabled = true
      this.photoTarget.classList.add("disabled-field")
    } else {
      this.photoTarget.disabled = false
      this.photoTarget.classList.remove("disabled-field")
    }
  }
}
