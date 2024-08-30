import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: className) as? Self else {
            fatalError("Failed to instantiate view controller with identifier: \(className)")
        }
        return viewController
    }

    private static var className: String {
        return String(describing: self)
    }
    
    private static var storyboardName: String {
        return "Main"
    }
}
