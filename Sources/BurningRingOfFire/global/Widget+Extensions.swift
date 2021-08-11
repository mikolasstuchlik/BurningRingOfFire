import Gtk

extension WidgetProtocol {
    /// Syntactic sugar for creating UI in the code. Provides reference to the instance in provided block and as a return type to allow chaining.
    public func apply(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}
