// Official widget initializer for X (Twitter) and Telegram embeds.
// Called on every Stimulus connect so widgets survive Turbo navigations.
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    provider: String,
    postId:   String
  }

  connect() {
    if (this.providerValue === "x")        this.#initX()
    if (this.providerValue === "telegram") this.#initTelegram()
  }

  async #initX() {
    if (!window.twttr) {
      await this.#loadScript("https://platform.twitter.com/widgets.js")
    }
    window.twttr?.widgets?.load(this.element)
  }

  #initTelegram() {
    // Remove any previously injected script (Turbo re-renders)
    this.element.querySelectorAll("script[data-telegram-post]").forEach((s) => s.remove())

    const script = document.createElement("script")
    script.setAttribute("async", "")
    script.src = "https://telegram.org/js/telegram-widget.js?22"
    script.dataset.telegramPost = this.postIdValue
    script.dataset.width = "100%"
    this.element.appendChild(script)
  }

  #loadScript(src) {
    return new Promise((resolve) => {
      if (document.querySelector(`script[src="${src}"]`)) { resolve(); return }
      const s = Object.assign(document.createElement("script"), { src, async: true })
      s.onload = resolve
      document.head.appendChild(s)
    })
  }
}
