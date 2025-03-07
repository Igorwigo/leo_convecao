import NavbarController from "./navbar_controller"
import ScheduleController from "./schedule_controller"

export function registerControllers(application) {
    application.register("navbar", NavbarController)
    application.register("schedule", ScheduleController)
}
