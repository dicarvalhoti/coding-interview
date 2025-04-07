import { Application } from "@hotwired/stimulus"

const application = Application.start()

// application.debug = process.env.NODE_ENV === "development"
window.Stimulus = application

export { application }
