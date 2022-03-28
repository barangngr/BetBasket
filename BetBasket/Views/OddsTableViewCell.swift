//
//  OddsTableViewCell.swift
//  BetBasket
//
//  Created by Baran Gungor on 28.03.2022.
//

import UIKit

final class OddsTableViewCell: BaseTableViewCell {
    
    // MARK: Properties
    private let homeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .headerColor
        label.font = UIFont(name: "Roboto-Medium", size: 14)
        label.textAlignment = .left
        return label
    }()
    
    private let awayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .headerColor
        label.font = UIFont(name: "Roboto-Medium", size: 14)
        label.textAlignment = .left
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .descpColor
        label.font = UIFont(name: "Roboto-Light", size: 10)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let oddStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.isUserInteractionEnabled = true
        view.spacing = 8
        return view
    }()
        
    // MARK: Functions
    override func commonInit() {
        super.commonInit()
        containerView.addSubview(views: homeLabel, awayLabel, timeLabel, oddStack)
        
        homeLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        homeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15).isActive = true
        homeLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        awayLabel.topAnchor.constraint(equalTo: homeLabel.bottomAnchor, constant: 2).isActive = true
        awayLabel.leadingAnchor.constraint(equalTo: homeLabel.leadingAnchor).isActive = true
        awayLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        timeLabel.topAnchor.constraint(equalTo: awayLabel.bottomAnchor, constant: 5).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: homeLabel.leadingAnchor).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        oddStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15).isActive = true
        oddStack.topAnchor.constraint(equalTo: homeLabel.bottomAnchor, constant: -5).isActive = true
    }
    
    func configure(_ model: OddsResponseModel) {
        homeLabel.text = model.homeTeam
        awayLabel.text = model.awayTeam
        timeLabel.text = model.commenceTime?.dateToString("d MMM HH:mm")

        let asd = model.bookmakers?.first?.markets?.first?.outcomes
        asd?.reversed().enumerated().forEach({
            let oddView = OddsView()
            oddView.delegate = self
            oddView.tag = $0
            oddView.isUserInteractionEnabled = true
            oddStack.addArrangedSubview(oddView)
            oddView.configure($1.price)
        })
    }
    
}

extension OddsTableViewCell: OddsViewDelegate {
    func didTapView(_ tag: Int) {
        oddStack.arrangedSubviews.forEach({
            if ($0 as? OddsView)?.tag != tag {
                ($0 as? OddsView)?.isSelected = false
            }
        })
    }
}
