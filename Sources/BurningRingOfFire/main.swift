import Gtk
import BurningFioAPI
import BurningModels
import BurningStorage


// MARK: - Main
let status = Application.run(startupHandler: nil) { app in
    let services = ServiceContainer()
    let w = RootWindow.linkedInit(
        controller: RootWindowController(inject: services),
        arguments: app
    )
    w.present()
    // TODO: Solve reference issue, remove hack
    w.ref()
}

guard let status = status else {
    fatalError("Could not create Application")
}
guard status == 0 else {
    fatalError("Application exited with status \(status)")
}