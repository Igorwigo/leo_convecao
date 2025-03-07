import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["dayButton", "dayContent"]

    connect() {
        // Ensure first day is active on load
        this.switchDay({ currentTarget: this.dayButtonTargets[0] })
    }

    switchDay(event) {
        const selectedDay = event.currentTarget.dataset.day

        // Update buttons
        this.dayButtonTargets.forEach(button => {
            if (button.dataset.day === selectedDay) {
                button.classList.add("bg-blue-600", "text-white")
                button.classList.remove("text-gray-500", "hover:text-gray-700")
            } else {
                button.classList.remove("bg-blue-600", "text-white")
                button.classList.add("text-gray-500", "hover:text-gray-700")
            }
        })

        // Update content visibility
        this.dayContentTargets.forEach(content => {
            if (content.dataset.day === selectedDay) {
                content.classList.remove("hidden")
            } else {
                content.classList.add("hidden")
            }
        })
    }
}
