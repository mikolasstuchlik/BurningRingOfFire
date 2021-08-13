import Gtk
import CGtk
import GLibObject
import GLib

extension TreeModelProtocol {

    func iterator(for index: Int) -> TreeIter? {
        var indice = gint(index)
        let path = TreePath.init(indicesv: &indice, length: 1)
        let iter = TreeIter()
        guard get(iter: iter, path: path) else { return nil }
        return iter
    }

    var count: Int {
        return iterNChildren(iter: nil)
    }

    var last: TreeIter {
        iterator(for: count - 1) ?? TreeIter()
    }

    var first: TreeIter {
        iterator(for: 0) ?? TreeIter()
    }

}

extension TreePathProtocol {

    var index: Int {
        Int(getIndices().pointee)
    }

}

extension TreeViewProtocol {
    
    func getSelectedRows() -> [Int] {
        var storage = UnsafeMutablePointer<GtkTreeModel>?.none
        var list: ListRef?
        withUnsafeMutablePointer(to: &storage) { ptr in
            list = getSelection().getSelectedRows(model: ptr)
        }

        guard let list = list else {
            return []
        }

        var indexes = [Int]()

        list.forEach { ptr in
            indexes.append(TreePathRef(raw: ptr).index)
        }
        g_list_free_full(list._ptr, { gtk_tree_path_free($0!.assumingMemoryBound(to: GtkTreePath.self)) })

        return indexes
    }

}