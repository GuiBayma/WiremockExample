import UIKit

enum Images {
    private static func getImage(_ name: String) -> UIImage {
        guard let image = Assets.getImage(for: name) else {
            fatalError("Could not get image named \(name)")
        }
        return image
    }

    static var octocat: UIImage {
        return getImage("octocat")
    }
}
