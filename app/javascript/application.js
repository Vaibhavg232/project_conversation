// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import { Application } from "@hotwired/stimulus"

// Start Stimulus application
const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

// Import controllers
import FormController from "./controllers/form_controller"
import NavigationController from "./controllers/navigation_controller"

// Register controllers
application.register("form", FormController)
application.register("navigation", NavigationController)

// Configure Turbo
document.addEventListener("turbo:load", () => {
  // Initialize any JavaScript that needs to run on page load
})

// Enable default link behavior
Turbo.setProgressBarDelay(100)

