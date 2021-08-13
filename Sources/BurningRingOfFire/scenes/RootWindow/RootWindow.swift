import Gtk
import Dispatch

class RootWindow: AppWindow<RootWindowController, ApplicationRef> {
    private lazy var header: HeaderBar! = HeaderBarRef().link(to: HeaderBar.self)?.apply {
        $0.setShowCloseButton(setting: true)
        $0.setCustomTitle(titleWidget: switcher)
    }

    private lazy var stack: Stack! = StackRef().link(to: Stack.self)

    private lazy var switcher: StackSwitcher! = StackSwitcherRef().link(to: StackSwitcher.self)?.apply {
        $0.set(stack: stack)
        $0.setHalign(align: .fill)
        $0.set(canFocus: false)
    }

    private lazy var overview: Label = Label(text: "Overview")

    private lazy var accounts: AccountsPage = AccountsPage.linkedInit(controller: AccountsPageController(inject: controller.container)).apply { $0.make() }

    private lazy var people: Label = Label(text: "People")
    
    private lazy var graphs: Label = Label(text: "Graphs")

    override func make() {
        stack.addTitled(child: overview, name: "Overview", title: "Overview")
        stack.addTitled(child: accounts, name: "Accounts", title: "Accounts")
        stack.addTitled(child: people, name: "People", title: "People")
        stack.addTitled(child: graphs, name: "Graphs", title: "Graphs")

        add(widget: stack)
        set(titlebar: header)
        setDefaultSize(width: 1024, height: 600)
    }    
}