import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="header--navbar"
export default class extends Controller {
  connect() {
    console.log("Connected to header--navbar controller");

  }
}
