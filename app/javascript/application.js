// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "./channels"
import { cable } from "@hotwired/turbo-rails"
window.cable = cable
