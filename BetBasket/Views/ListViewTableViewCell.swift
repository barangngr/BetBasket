//
//  ListViewTableViewCell.swift
//  BetBasket
//
//  Created by Baran Gungor on 24.03.2022.
//

import UIKit

final class ListViewTableViewCell: BaseTableViewCell {
    
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
