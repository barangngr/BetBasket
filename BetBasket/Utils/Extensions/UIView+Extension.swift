//
//  UIView+Extension.swift
//  BetBasket
//
//  Created by Baran Gungor on 24.03.2022.
//

import UIKit

extension UIView {
    
    enum Direct {
        case horizontal, vertical, all
    }
    
    func addSubview(views: UIView...) {
        views.forEach {addSubview($0)}
    }
    
    func addSubview(views: [UIView]) {
        views.forEach {addSubview($0)}
    }
    
    func fill(_ direction: Direct, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            switch direction {
            case .horizontal:
                leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant).isActive = true
                trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -constant).isActive = true
            case .vertical:
                topAnchor.constraint(equalTo: superview.topAnchor, constant: constant).isActive = true
                bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant).isActive = true
            case .all:
                topAnchor.constraint(equalTo: superview.topAnchor, constant: constant).isActive = true
                bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant).isActive = true
                leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant).isActive = true
                trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -constant).isActive = true
            }
        }
    }
}

