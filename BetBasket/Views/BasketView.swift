//
//  BasketView.swift
//  BetBasket
//
//  Created by Baran Gungor on 29.03.2022.
//

import UIKit

protocol BasketViewDelegate: AnyObject {
    func didTapView()
}

final class BasketView: UIView {

    // MARK: Properties
    private let matchLabel: UILabel = {
        let label = UILabel()
        label.textColor = .headerColor
        label.font = UIFont(name: "Roboto-Bold", size: 12)
        label.textAlignment = .center
        return label
    }()
    
    private let oddLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .headerColor
        label.font = UIFont(name: "Roboto-Bold", size: 12)
        label.textAlignment = .center
        return label
    }()
    
    weak var delegate: BasketViewDelegate?
        
    // MARK: Initiliaze
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
        
    // MARK: Functions
    private func commonInit() {
        backgroundColor = .basketColor
        alpha = 0
        layer.cornerRadius = 25
        addSubview(views: matchLabel, oddLabel)
        
        matchLabel.fill(.horizontal)
        matchLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        matchLabel.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -4).isActive = true
        
        oddLabel.fill(.horizontal)
        oddLabel.topAnchor.constraint(equalTo: matchLabel.bottomAnchor, constant: 2).isActive = true
        oddLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        addGestureRecognizer(tap)
    }
    
    func configure() {
        matchLabel.text = "\(OddsManager.shared.oddSource.count) Match"
        oddLabel.text = String(format:"%.2f", OddsManager.shared.totalOdd)
        showView()
    }
    
    private func showView() {
        UIView.animate(withDuration: 0.5) {
            self.alpha = 1
        }
    }
    
    // MARK: Action
    @objc func tapAction() {
        delegate?.didTapView()
    }
    
}
