import Gtk
import CGtk

class AppWindow: Gtk.ApplicationWindow {
    static func linkedInit<ApplicationT: ApplicationProtocol>(application: ApplicationT) -> Self {
        let ref = ApplicationWindowRef(application: application)
        let new = ref.link(to: Self.self)
        return new!
    }

    final func present() {
        make()
        showAll()
    }

    func make() { fatalError("make() not implemented") }
}

class Window: Gtk.Window {
    static func linkedInit( type: GtkWindowType) -> Self {
        let ref = WindowRef(type: type)
        let new = ref.link(to: Self.self)
        return new!
    }

    final func present() {
        make()
        showAll()
    }

    func make() { fatalError("make() not implemented") }
}
