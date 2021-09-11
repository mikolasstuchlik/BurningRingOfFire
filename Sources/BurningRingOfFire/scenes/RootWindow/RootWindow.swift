import Gtk
import Dispatch
import Gdk

class RootWindow: AppWindow<RootWindowController, ApplicationRef> {
    private lazy var header: HeaderBar! = HeaderBarRef().link(to: HeaderBar.self)?.apply {
        $0.setShowCloseButton(setting: true)
        $0.setCustomTitle(titleWidget: switcher)
    }

    private lazy var stack: Stack! = StackRef().link(to: Stack.self)

    private lazy var switcher: StackSwitcher! = StackSwitcherRef().link(to: StackSwitcher.self)?.apply {
        $0.set(stack: stack)
        $0.setHalign(align: .fill)
    }

    private lazy var overview: Label = Label(text: "Overview")

    private lazy var accounts: AccountsPage = AccountsPage.linkedInit(controller: AccountsPageController(inject: controller.container)).apply { $0.make() }

    private lazy var people: Label = Label(text: "People")
    
    private lazy var graphs: Label = Label(text: "Graphs")

    private lazy var acelGroup: AccelGroup! = {
        let group = AccelGroupRef().link(to: AccelGroup.self)!
        add(accelGroup: group)
        return group    
    }()

    private lazy var fileItem: MenuItem! = MenuItemRef(label: "File").link(to: MenuItem.self)?.apply { item in
        item.set(submenu: fileMenu)
    }

    private lazy var quitItem: MenuItem! = MenuItemRef(label: "Quit").link(to: MenuItem.self)?.apply { item in

        // This connects a keybinding to the option
        item.addAccelerator(
            accelSignal: "activate", 
            accelGroup: acelGroup, 
            accelKey: Int(Gdk.KEY_q), 
            accelMods: ModifierType.controlMask, 
            accelFlags: AccelFlags.visible
        )

        // This happens when you click on the menu
        item.onActivate { [weak self] _ in
            self?.application?.quit()
        }
    }

    private lazy var menuBar: MenuBar! = MenuBarRef().link(to: MenuBar.self)?.apply { bar in
        bar.append(child: fileItem)
    } 

    private lazy var fileMenu: Menu! = MenuRef().link(to: Menu.self)?.apply { menu in
        menu.append(child: quitItem)
    }

    override func make() {
        let box = Gtk.Box(orientation: .vertical, spacing: 0)
        stack.addTitled(child: overview, name: "Overview", title: "Overview")
        stack.addTitled(child: accounts, name: "Accounts", title: "Accounts")
        stack.addTitled(child: people, name: "People", title: "People")
        stack.addTitled(child: graphs, name: "Graphs", title: "Graphs")

        add(widget: box)
        box.packStart(child: stack, expand: true, fill: true, padding: 0)
        box.packStart(child: menuBar, expand: false, fill: false, padding: 0)
        set(titlebar: header)
        setDefaultSize(width: 1024, height: 600)
    }    
}