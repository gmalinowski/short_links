import { Controller } from "@hotwired/stimulus"
import { gsap } from "gsap"

export default class extends Controller {
    connect() {
        if (this.element.dataset.animated === "true") return
        this.element.dataset.animated = "true"
        this.animate()
        // document.addEventListener("turbo:load", this.animate)
    }
    disconnect() {
        // document.removeEventListener("turbo:load", this.animate)
    }

    animate = () => {
        gsap.from(this.element, {
            x: -200,     // start 100px na lewo
            opacity: 0,  // start niewidoczny
            duration: 0.5,
            ease: "power2.out"
        });
    }
}