//
//  BaseTableViewCell.swift
//  BetBasket
//
//  Created by Baran Gungor on 24.03.2022.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    // MARK: Properties
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .cellBackColor
        view.layer.cornerRadius = 18
        return view
    }()
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .headerColor
        label.font = UIFont(name: "Roboto-Bold", size: 14)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let descpLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .descpColor
        label.font = UIFont(name: "Roboto-Medium", size: 11)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: Initiliaze
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: Functions
    func commonInit() {
        backgroundColor = .clear
        addSubview(views: containerView)
        containerView.fill(.vertical, constant: 5)
        containerView.fill(.horizontal, constant: 10)
    }
    
}
