
export function emitFlash(message, type = "info") {
    const event = new CustomEvent("local_flash", { detail: { message, type }, bubbles: true })
    document.dispatchEvent(event)
}