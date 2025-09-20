import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        if (!document.cookie.includes("time_zone")) {
            const timeZone = Intl.DateTimeFormat().resolvedOptions().timeZone
            console.log(timeZone)
            document.cookie = `time_zone=${timeZone}; path=/; max-age=3600`
        }
    }
}