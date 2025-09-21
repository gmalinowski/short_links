import { Controller } from "@hotwired/stimulus"
import { emitFlash } from "utils/local_flash"

export default class extends Controller {
    static values = { copyContent: String }
    copy() {
        navigator.clipboard.writeText(this.copyContentValue)
        emitFlash("Short link copied to clipboard!", "success")
    }

}