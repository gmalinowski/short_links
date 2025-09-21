import { Controller } from "@hotwired/stimulus"
import {gsap} from "gsap"

export default class extends Controller {
    static targets = ["text", "countdown"]
    connect() {
        window.addEventListener("local_flash", this.show.bind(this))
    }

    show({ detail: { message, type }}) {
        this.element.classList.add("alert-" + type)
        this.textTarget.textContent = message

        gsap.fromTo(this.element, {
            y: 100,
            display: "none",
            opacity: 0
        }, {
            y: 0,
            display: "block",
            opacity: 1,
            duration: 1,
            ease: "power3.out"
        })

        setTimeout(() => {
            gsap.to(this.element, {
                display: "none",
                y: -100,
                opacity: 0,
                duration: 1,
            })
        }, 5000)
    }
}