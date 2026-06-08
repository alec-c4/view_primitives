import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  open({ params: { src, alt } }) {
    if (this._overlay) return
    const overlay = document.createElement("div")
    overlay.className = "vp-overlay flex items-center justify-center p-4"
    overlay.dataset.galleryOverlay = ""

    const img = document.createElement("img")
    img.src = src
    img.alt = alt || ""
    img.className = "max-h-[90vh] max-w-[90vw] rounded-md object-contain"
    overlay.appendChild(img)

    document.body.appendChild(overlay)
    this._overlay = overlay
  }

  close() {
    this._overlay?.remove()
    this._overlay = null
  }

  closeOnClickOutside(event) {
    if (event.target === this._overlay) this.close()
  }
}
