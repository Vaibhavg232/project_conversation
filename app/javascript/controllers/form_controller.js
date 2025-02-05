import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // console.log("Form controller connected")
  }

  initialize() {
    this.handleSubmit = this.handleSubmit.bind(this)
  }

  handleSubmit(event) {
    event.preventDefault()
    
    const form = event.target
    const formData = new FormData(form)

    fetch(form.action, {
      method: form.method,
      body: formData,
      headers: {
        "Accept": "text/vnd.turbo-stream.html, text/html",
        "X-Requested-With": "XMLHttpRequest"
      },
      credentials: "same-origin",
      redirect: "follow"
    })
    .then(response => {
      if (response.redirected) {
        window.location.href = response.url
      } else {
        return response.text().then(html => {
          if (html.includes('turbo-stream')) {
            Turbo.renderStreamMessage(html)
            // Clear form if it's a comment form
            if (form.querySelector('textarea[name="comment[body]"]')) {
              form.reset()
            }
          }
        })
      }
    })
    .catch(error => {
      console.error("Error submitting form:", error)
    })
  }
} 