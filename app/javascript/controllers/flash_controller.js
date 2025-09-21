import { Controller } from "@hotwired/stimulus"
import { gsap } from "gsap"

export default class extends Controller {
    connect() {


        this.animate()
    }

    animate() {
        gsap.to(this.element, {
            opacity: 0,
            duration: 1,   // fade out
            delay: 5,      // po 5 sekundach
            onComplete: () => {
                const el = this.element;
                if (el) el.remove();
            }
        });
        const counter = { value: 5 };
        const el = this.element.querySelector(".countdown")

        gsap.to(counter, {
            value: 0,
            duration: 6,      // 5 sekund
            roundProps: "value", // zaokrągla do całkowitych
            onUpdate: () => {
                el.textContent = counter.value;
            },
        });
    }
}