import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["toast"]
  #timers = new Map()

  connect() {
    this.toastTargets.forEach(toast => this.#show(toast))
  }

  // Triggered by: window.dispatchEvent(new CustomEvent("toaster:add", { detail: { message, title, variant, duration } }))
  add({ detail }) {
    const toast = this.#buildToast(detail)
    this.element.appendChild(toast)
    this.#show(toast)
  }

  dismiss({ currentTarget }) {
    this.#hide(currentTarget.closest("[data-toaster-target='toast']"))
  }

  #show(toast) {
    requestAnimationFrame(() => {
      toast.dataset.open = "true"
      const duration = parseInt(toast.dataset.toasterDurationParam ?? "4000")
      if (duration > 0) {
        this.#timers.set(toast, setTimeout(() => this.#hide(toast), duration))
      }
    })
  }

  #hide(toast) {
    if (!toast) return
    clearTimeout(this.#timers.get(toast))
    this.#timers.delete(toast)
    toast.dataset.open = "false"
    toast.addEventListener("transitionend", () => toast.remove(), { once: true })
  }

  #buildToast({ message = "", title = "", variant = "default", duration = 4000 }) {
    const borderCls = {
      default: "border-border",
      success: "border-chart-2/40",
      warning: "border-chart-4/40",
      destructive: "border-destructive/40",
      info: "border-border"
    }[variant] ?? "border-border"

    const div = document.createElement("div")
    div.setAttribute("role", "alert")
    div.setAttribute("aria-live", "polite")
    div.dataset.open = "false"
    div.dataset.toasterTarget = "toast"
    div.dataset.toasterDurationParam = duration
    div.className = [
      "pointer-events-auto flex items-start gap-3 rounded-md vp-border",
      "bg-popover px-4 py-3 text-popover-foreground shadow-md outline-hidden",
      "transition-all duration-300 translate-y-2 opacity-0",
      "data-[open=true]:translate-y-0 data-[open=true]:opacity-100",
      borderCls
    ].join(" ")

    const bodyHtml = title
      ? `<p class="text-sm font-semibold leading-tight">${this.#esc(title)}</p>
         <p class="text-sm leading-snug text-muted-foreground mt-0.5">${this.#esc(message)}</p>`
      : `<p class="text-sm leading-snug">${this.#esc(message)}</p>`

    div.innerHTML = `
      <div class="flex-1 min-w-0">${bodyHtml}</div>
      <button type="button" aria-label="Dismiss"
        data-action="click->toaster#dismiss"
        class="ml-auto -mr-1 -mt-0.5 shrink-0 inline-flex size-6 items-center justify-center
               rounded-md text-muted-foreground hover:text-foreground hover:bg-accent
               vp-focus-ring outline-hidden transition">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
             stroke="currentColor" stroke-width="2" class="size-3.5" aria-hidden="true">
          <path d="M18 6 6 18M6 6l12 12" stroke-linecap="round" stroke-linejoin="round"/>
        </svg>
      </button>`
    return div
  }

  #esc(str) {
    return String(str)
      .replace(/&/g, "&amp;").replace(/</g, "&lt;")
      .replace(/>/g, "&gt;").replace(/"/g, "&quot;")
  }
}
