import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // console.log("Navigation controller connected")
  }

  navigate(event) {
    const href = event.currentTarget.getAttribute("href")
    if (href) {
      Turbo.visit(href)
    }
  }
} 