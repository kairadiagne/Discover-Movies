import UIKit

protocol Reusable {
    static var reuseId: String { get }
}

protocol NibLoadable {
    static var nibName: String { get }
    static var nib: UINib { get }
}

typealias NibReusable = Reusable & NibLoadable

extension Reusable where Self: UIView {

    static var reuseId: String {
        return String(describing: self)
    }
}

extension NibLoadable where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }

    static var nib: UINib {
        return UINib(nibName: self.nibName, bundle: Bundle(for: self))
    }

    static func loadFromNib(withOwner owner: Any? = nil) -> Self? {
        // top-level objects in nib file
        let nibObjects = self.nib.instantiate(withOwner: owner, options: nil)

        // find Self match
        for obj in nibObjects {
            if let obj = obj as? Self {
                return obj
            }
        }
        return nil
    }
}

extension UITableView {

    func register<T: UITableViewCell & Reusable>(reusableCell: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseId)
    }

    func register<T: UITableViewCell & NibReusable>(nibReusableCell: T.Type) {
        register(T.nib, forCellReuseIdentifier: T.reuseId)
    }

    func register<T: UITableViewHeaderFooterView & NibReusable>(nibReusableHeaderFooterView: T.Type) {
        register(T.nib, forHeaderFooterViewReuseIdentifier: T.reuseId)
    }

    func dequeueReusableCell<T: UITableViewCell & Reusable>(forIndexPath indexPath: IndexPath) -> T {
        // swiftlint:disable:next force_cast
        return dequeueReusableCell(withIdentifier: T.reuseId, for: indexPath) as! T
    }

    func dequeueNibReusableCell<T: UITableViewCell & NibReusable>(forIndexPath indexPath: IndexPath) -> T {
        // swiftlint:disable:next force_cast
        return dequeueReusableCell(withIdentifier: T.reuseId, for: indexPath) as! T
    }

    func dequeueNibReusableHeaderFooterView<T: UITableViewHeaderFooterView & NibReusable>() -> T {
        // swiftlint:disable:next force_cast
        return dequeueReusableHeaderFooterView(withIdentifier: T.reuseId)! as! T
    }
}

extension UICollectionView {

    func registerReusableCell<T: UICollectionViewCell & Reusable>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseId)
    }

    func registerNibReusableCell<T: UICollectionViewCell & NibReusable>(_: T.Type) {
        register(T.nib, forCellWithReuseIdentifier: T.reuseId)
    }

    func dequeueReusableCell<T: UICollectionViewCell & Reusable>(forIndexPath indexPath: IndexPath) -> T {
        // swiftlint:disable:next force_cast
        return dequeueReusableCell(withReuseIdentifier: T.reuseId, for: indexPath) as! T
    }

    func dequeueNibReusableCell<T: UICollectionViewCell & NibReusable>(forIndexPath indexPath: IndexPath) -> T {
        // swiftlint:disable:next force_cast
        return dequeueReusableCell(withReuseIdentifier: T.reuseId, for: indexPath) as! T
    }
}
