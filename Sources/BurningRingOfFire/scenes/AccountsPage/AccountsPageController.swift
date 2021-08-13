final class AccountsPageController: Controller {

    weak var scene: AccountsPage?

    private var counter = 0

    func addToListEvent() { 
        counter += 1
        scene?.modelAdd(title: "Line \(counter)", selected: Bool.random())
    }

    func removeFromListEvent() {
        if let selected = scene?.getSelectedRows().first {
            scene?.modelRemove(at: selected)
        }
    }

    init(inject services: ServiceContainer, arguments: Void) {
        
    }
}