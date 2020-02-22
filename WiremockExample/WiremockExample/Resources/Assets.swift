import UIKit

final class Assets {
    static func getBundle() -> Bundle {
        return Bundle(for: self)
    }

    static func getImage(for name: String) -> UIImage? {
        return UIImage(named: name, in: getBundle(), compatibleWith: nil)
    }
}
