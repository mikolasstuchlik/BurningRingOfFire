final class RootWindowController: Controller {
    weak var scene: RootWindow?

    let container: ServiceContainer

    init(inject services: ServiceContainer, arguments: Void) {
        container = services
    }
}