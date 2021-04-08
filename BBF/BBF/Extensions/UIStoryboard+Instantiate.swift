import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let storyboardName = Self.description().storyboardName()
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}

extension String {
    private var name: String {
        return self.components(separatedBy: ".")[1]
    }
    
    func storyboardName() -> String {
        return name
    }
    
    func nibName() -> String {
        return name
    }
}
