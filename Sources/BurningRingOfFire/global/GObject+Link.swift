import GLibObject

extension GLibObject.ObjectProtocol {
    func link<T: GLibObject.Object>(to type: T.Type) -> T? {
        if let existing = self.swiftObj {
            if let correct = existing as? T {
                return correct
            } else {
                assertionFailure("Object is already linked but not related.")
                return nil
            }
        }

        if isFloating {
            refSink()
        }
        let new = T.init(raw: self.ptr)

        self.swiftObj = new
        return new
    }
}
