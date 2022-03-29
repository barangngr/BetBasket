//
//  ListViewTableViewCell.swift
//  BetBasket
//
//  Created by Baran Gungor on 24.03.2022.
//

import UIKit

final class ListViewTableViewCell: BaseTableViewCell {
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .headerColor
        label.font = UIFont(name: "Roboto-Bold", size: 14)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let descpLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .descpColor
        label.font = UIFont(name: "Roboto-Medium", size: 11)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: Functions
    override func commonInit() {
        super.commonInit()
        containerView.addSubview(views: headerLabel, descpLabel)
        
        headerLabel.fill(.horizontal, constant: 15)
        headerLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8).isActive = true
        headerLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 15).isActive = true
        
        descpLabel.fill(.horizontal, constant: 15)
        descpLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 2).isActive = true
        descpLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8).isActive = true
    }
    
    func configure(_ model: ListResponseModel) {
        headerLabel.text = model.title ?? "--"
        descpLabel.text = model.description ?? "--"
    }
    
}
