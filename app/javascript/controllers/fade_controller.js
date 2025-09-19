import { Controller } from "@hotwired/stimulus"
import { gsap } from "gsap"

export default class extends Controller {
    connect() {
        gsap.from(this.element, {
            x: -200,     // start 100px na lewo
            opacity: 0,  // start niewidoczny
            duration: 0.5,
            ease: "power2.out"
        });
    }
}