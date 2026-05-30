// Quill adapter — requires Quill v2 in your importmap:
//   pin "quill", to: "https://esm.sh/quill@2"
// Also add Quill's stylesheet to your CSS entry point:
//   @import url("https://esm.sh/quill@2/dist/quill.snow.css");
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["editor", "input"]
  static values  = {
    adapter:     { type: String,  default: "trix" },
    placeholder: { type: String,  default: "" },
    height:      { type: Number,  default: 200 },
    toolbar:     { type: Boolean, default: true }
  }

  #quill = null

  connect() {
    if (this.adapterValue === "quill") this.#initQuill()
  }

  disconnect() {
    this.#quill = null
  }

  async #initQuill() {
    const { default: Quill } = await import("quill")
    this.#quill = new Quill(this.editorTarget, {
      theme: "snow",
      placeholder: this.placeholderValue,
      modules: { toolbar: this.toolbarValue }
    })
    if (this.inputTarget.value) {
      this.#quill.root.innerHTML = this.inputTarget.value
    }
    this.#quill.on("text-change", () => {
      this.inputTarget.value = this.#quill.root.innerHTML
    })
  }
}
