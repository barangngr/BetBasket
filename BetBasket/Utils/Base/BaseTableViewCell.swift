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
        contentView.addSubview(containerView)
        contentView.isUserInteractionEnabled = true
        containerView.fill(.vertical, constant: 6)
        containerView.fill(.horizontal, constant: 10)
    }
    
}
// The base structure could be applied in the 3 viewcontrollers used, but I didn't want to use it because I applied it to the cells.
