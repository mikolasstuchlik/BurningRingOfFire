import Gtk
import CGtk
import GLibObject
import GLib

final class AccountsPage: Box<AccountsPageController>, DefaultArguments {
    static var defaultArguemnt: SceneArguments {
        (orientation: .vertical, spacing: 1)
    }

    private lazy var model: ListStore = ListStore(.string, .boolean)

    private lazy var treeView: TreeView! = TreeViewRef(model: model).link(to: TreeView.self)?.apply {

        let columns: [(String, PropertyName, CellRenderer)] = [
            ("Title", "text",   CellRendererText()),
            ("Check", "active", CellRendererToggle())
        ]
        
        $0.append(columns.enumerated().map { (index, data) -> TreeViewColumn in
            TreeViewColumn(index, title: data.0, renderer: data.2, attribute: data.1)
        })

        $0.getSelection().setMode(type: .single)
    }

    private lazy var scroll: ScrolledWindow! = ScrolledWindowRef(hadjustment: Optional<Adjustment>.none, vadjustment: nil).link(to: ScrolledWindow.self)?.apply {
        $0.add(widget: treeView)
    }

    private lazy var pickerBox: Gtk.Box! = BoxRef(orientation: .vertical, spacing: 1).link(to: Gtk.Box.self)?.apply {
        $0.packStart(child: scroll, expand: true, fill: true, padding: 1)
        $0.packStart(child: actionBar, expand: false, fill: false, padding: 1)        
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

    func modelAdd(title: String, selected: Bool) {
        model.append(asNextRow: model.last, Value(title), Value(selected))
    }

    func getSelectedRows() -> [Int] {
        treeView.getSelectedRows()
    }

    func modelRemove(at index: Int) {
        _ = model.iterator(for: index).flatMap(model.remove(iter:))
    }

    override func make() {
        packStart(child: pickerBox, expand: true, fill: true, padding: 1)
    }
}