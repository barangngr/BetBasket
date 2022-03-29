//
//  OddsView.swift
//  BetBasket
//
//  Created by Baran Gungor on 28.03.2022.
//

import UIKit

protocol OddsViewDelegate: AnyObject {
    func didTapView(_ tag: Int, odd: Double)
}

class OddsView: UIButton {

    // MARK: Properties
    fileprivate let oddLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .backColor
        label.font = UIFont(name: "Roboto-Bold", size: 16)
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        return label
    }()
    
    fileprivate let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    var odd: Double?
    weak var delegate: OddsViewDelegate?
        
    // MARK: Initiliaze
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override var isSelected: Bool {
        didSet {
            containerView.backgroundColor = isSelected ? .selectedColor : .white
            setNeedsDisplay()
        }
    }
    
    // MARK: Functions
    fileprivate func commonInit() {
        backgroundColor = .clear
        addSubview(views: containerView)
        containerView.fill(.all)
        
        containerView.addSubview(oddLabel)
        oddLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        oddLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        oddLabel.fill(.all, constant: 5)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(oddLabelAction))
        oddLabel.addGestureRecognizer(tap)
    }
    
    @objc func oddLabelAction() {
        guard let odd = odd else { return }
        delegate?.didTapView(self.tag, odd: odd)
        isSelected.toggle()
    }
    
    func configure(_ odd: Double?) {
        guard let odd = odd else { return }
        self.odd = odd
        oddLabel.text = "\(odd)"
    }
}

// MARK: - WinnerOddView
class WinnerOddView: OddsView {
    
    // MARK: Properties
    fileprivate let teamLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .headerColor
        label.font = UIFont(name: "Roboto-Bold", size: 14)
        label.textAlignment = .left
        return label
    }()
    
    // MARK: Functions
    override func commonInit() {
        backgroundColor = .clear
        addSubview(views: teamLabel, containerView)
        
        teamLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        teamLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        teamLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        containerView.fill(.vertical, constant: 5)
        
        containerView.addSubview(oddLabel)
        oddLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        oddLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        oddLabel.fill(.all, constant: 5)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(oddLabelAction))
        oddLabel.addGestureRecognizer(tap)
    }
    
    func configure(_ model: OutcomeModel?) {
        guard let model = model, let price = model.price else { return }
        self.odd = price
        teamLabel.text = model.name
        oddLabel.text = "\(price)"
    }
}
