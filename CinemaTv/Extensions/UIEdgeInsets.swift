import UIKit

public extension UIEdgeInsets {
    /// Set the same inset to all sides of Insets.
    ///
    /// - Parameter inset: common inset value between all sides.
    init(inset: CGFloat) {
        self.init(top: inset, left: inset, bottom: inset, right: inset)
    }
}
