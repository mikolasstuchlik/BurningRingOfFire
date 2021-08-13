import Gtk
import CGtk

protocol Controller: AnyObject {
    associatedtype Arguments
    associatedtype SceneInputType

    var scene: SceneInputType? { get set }

    init(inject services: ServiceContainer, arguments: Arguments)
}

extension Controller where Arguments == Void {
    init(inject services: ServiceContainer) {
        self.init(inject: services, arguments: Void())
    }
}

protocol Scene {
    associatedtype SceneController: Controller
    associatedtype SceneArguments

    var controller: SceneController! { get }
    
    static func linkedInit(controller: SceneController, arguments: SceneArguments) -> Self
}

extension Scene where SceneArguments == Void {
    static func linkedInit(controller: SceneController) -> Self {
        linkedInit(controller: controller, arguments: Void())
    }
}

protocol DefaultArguments {
    associatedtype DefaultArgument
    static var defaultArguemnt: DefaultArgument { get }
}

extension Scene where Self: DefaultArguments, SceneArguments == DefaultArgument {
    static func linkedInit(controller: SceneController) -> Self {
        linkedInit(controller: controller, arguments: defaultArguemnt)
    }
}

class AppWindow<C: Controller, A: ApplicationProtocol>: Gtk.ApplicationWindow, Scene {
    private(set) var controller: C!

    static func linkedInit(controller: C, arguments: A) -> Self {
        let ref = ApplicationWindowRef(application: arguments)
        let new = ref.link(to: Self.self)
        new?.controller = controller
        if let scene = new as? C.SceneInputType {
            controller.scene = scene
        } else {
            assertionFailure("Failed to link \(self) to \(controller)")
        }
        return new!
    }

    final func present() {
        make()
        showAll()
    }

    func make() { fatalError("make() not implemented") }
}

class Window<C: Controller>: Gtk.Window, Scene {
    private(set) var controller: C!

    static func linkedInit(controller: C, arguments: CGtk.GtkWindowType) -> Self {
        let ref = WindowRef(type: arguments)
        let new = ref.link(to: Self.self)
        new?.controller = controller
        if let scene = new as? C.SceneInputType {
            controller.scene = scene
        } else {
            assertionFailure("Failed to link \(self) to \(controller)")
        }
        return new!
    }

    final func present() {
        make()
        showAll()
    }

    func make() { fatalError("make() not implemented") }
}

class Box<C: Controller>: Gtk.Box, Scene {
    typealias SceneArguments = (orientation: GtkOrientation, spacing: Int)

    private(set) var controller: C!

    static func linkedInit(controller: C, arguments: SceneArguments) -> Self {
        let ref = BoxRef(orientation: arguments.orientation, spacing: arguments.spacing)
        let new = ref.link(to: Self.self)
        new?.controller = controller
        if let scene = new as? C.SceneInputType {
            controller.scene = scene
        } else {
            assertionFailure("Failed to link \(self) to \(controller)")
        }
        return new!
    }

    func make() { fatalError("make() not implemented") }
}

