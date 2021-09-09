import Gtk
import CGtk
import GLibObject
import GLib
import Cairo
import CCairo

final class AccountsPage: Box<AccountsPageController>, DefaultArguments {
    static var defaultArguemnt: SceneArguments {
        (orientation: .vertical, spacing: 10)
    }

    // MARK: - Left section 
    private lazy var model: ListStore = ListStore(.string)

    private lazy var treeView: TreeView! = TreeViewRef(model: model).link(to: TreeView.self)?.apply {
        $0.append(TreeViewColumn(0, title: "Account name", renderer: CellRendererText(), attribute: "text"))
        $0.getSelection().setMode(type: .single)
    }

    private lazy var scroll: ScrolledWindow! = ScrolledWindowRef(hadjustment: Optional<Adjustment>.none, vadjustment: nil).link(to: ScrolledWindow.self)?.apply {
        $0.add(widget: treeView)
    }

    private lazy var pickerBox: Gtk.Box! = BoxRef(orientation: .vertical, spacing: 1).link(to: Gtk.Box.self)?.apply {
        $0.packStart(child: scroll, expand: true, fill: true, padding: 1)
        $0.packStart(child: actionBar, expand: false, fill: false, padding: 1)
        $0.setSizeRequest(width: 300, height: -1)        
    }

    private lazy var actionBar: ActionBar! = ActionBarRef().link(to: ActionBar.self)?.apply {
        $0.packStart(child: addButton)
        $0.packStart(child: removeButton)
    }

    private lazy var addButton: Button! = ButtonRef().link(to: Button.self)?.apply {
        $0.set(image: Image(iconName: "list-add", size: .button))
        $0.onClicked { [weak self] _ in self?.controller.addToListEvent() }
    }

    private lazy var removeButton: Button! = ButtonRef().link(to: Button.self)?.apply {
        $0.set(image: Image(iconName: "list-remove", size: .button))
        $0.onClicked { [weak self] _ in self?.controller.removeFromListEvent() }
    }

    // MARK: - Right section
    private lazy var accountHeadline: Label! = LabelRef.init(str: nil).link(to: Label.self)?.apply {
        $0.set(markup: "<big><big><big><b>Account configuration</b></big></big></big>")
    }

    private lazy var nameInput: Entry! = EntryRef().link(to: Entry.self)

    private lazy var addTokenButton: Button! = ButtonRef().link(to: Button.self)?.apply {
        $0.set(label: "Change token")
        $0.onClicked { [weak self] _ in self?.controller.addToListEvent() }
    }

    private lazy var validityLabel: Label! = LabelRef(mnemonic: "").link(to: Label.self)

    private lazy var formGrid: Grid! = GridRef().link(to: Grid.self)?.apply {
        $0.setRow(spacing: 10)
        $0.setColumn(spacing: 10)
        $0.attach(child: accountHeadline,       left: 0, top: 0, width: 5, height: 1)

        $0.attach(child: Label(text: "Name"),   left: 0, top: 1, width: 1, height: 1)
        $0.attach(child: nameInput,             left: 1, top: 1, width: 4, height: 1)

        $0.attach(child: Label(text: "Token"),  left: 0, top: 2, width: 1, height: 1)
        $0.attach(child: addTokenButton,        left: 1, top: 2, width: 1, height: 1)
        $0.attach(child: validityLabel,         left: 3, top: 2, width: 1, height: 1)
    }

    // MARK: - General

    private lazy var separator: Separator! = SeparatorRef(orientation: .vertical).link(to: Separator.self)

    private lazy var hBox: Gtk.Box! = BoxRef(orientation: .horizontal, spacing: 1).link(to: Gtk.Box.self)?.apply {
        $0.packStart(child: pickerBox, expand: false, fill: true, padding: 10)
        $0.packStart(child: separator, expand: false, fill: false, padding: 0)
        $0.packStart(child: formGrid, expand: true, fill: true, padding: 10)
    }

    override func make() {
        packStart(child: hBox, expand: true, fill: true, padding: 10)
    }

    // MARK: - Inputs
    func modelAdd(title: String) {
        model.append(asNextRow: model.last, Value(title))
    }

    func getSelectedRows() -> [Int] {
        treeView.getSelectedRows()
    }

    func modelRemove(at index: Int) {
        _ = model.iterator(for: index).flatMap(model.remove(iter:))
    }
}