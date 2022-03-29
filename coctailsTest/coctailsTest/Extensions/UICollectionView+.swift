//
//  UICollectionView+.swift
//  coctailsTest
//
//  Created by Anatoliy on 29.03.2022.
//

import UIKit

protocol ReuseIdentifiable {
    static var reuseIdentifire: String { get }
}

extension ReuseIdentifiable {
    static var reuseIdentifire: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReuseIdentifiable {
}

extension UITableViewHeaderFooterView: ReuseIdentifiable {
}

extension UICollectionReusableView: ReuseIdentifiable {
}

extension UICollectionView {
    func dequeueCell<T: UICollectionViewCell>(cellType: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifire, for: indexPath) as? T else {
            fatalError("can't dequeue")
        }
        return cell
    }
    
    func register<T: UICollectionViewCell>(_ cellType: T.Type) {
        self.register(cellType, forCellWithReuseIdentifier: cellType.reuseIdentifire)
    }
}

extension UITableView {
    func dequeueCell<T: UITableViewCell>(cellType: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifire, for: indexPath) as? T else {
            fatalError("can't dequeue")
        }
        return cell
    }
    
    func register<T: UITableViewCell>(_ cellType: T.Type) {
        self.register(cellType, forCellReuseIdentifier: cellType.reuseIdentifire)
    }
}
