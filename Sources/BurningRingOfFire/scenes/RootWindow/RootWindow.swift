import Gtk

class RootWindow: AppWindow {
    private lazy var header: HeaderBar! = {
        let bar = HeaderBarRef().link(to: HeaderBar.self)

        bar?.setShowCloseButton(setting: true)
        bar?.setCustomTitle(titleWidget: switcher)
        bar?.setHasSubtitle(setting: true)
        bar?.set(subtitle: "Lolec")

        return bar
    }()

    private lazy var stack: Stack! = {
        let stack = StackRef().link(to: Stack.self)

        return stack
    }()

    private lazy var switcher: StackSwitcher! = {
        let switcher = StackSwitcherRef().link(to: StackSwitcher.self)
        switcher?.set(stack: stack)
        switcher?.setHalign(align: .fill)
        switcher?.setFocus()
        return switcher
    }()

    override func make() {
        let label1 = Label(text: "Hello")
        let label2 = Label(text: "Miki")

        stack.addTitled(child: label1, name: "A", title: "a")
        stack.addTitled(child: label2, name: "B", title: "b")

        add(widget: stack)
        set(titlebar: header)
    }    
}