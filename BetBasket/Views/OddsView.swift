//
//  OddsView.swift
//  BetBasket
//
//  Created by Baran Gungor on 28.03.2022.
//

import UIKit

protocol OddsViewDelegate: AnyObject {
    func didTapView(_ tag: Int)
}

final class OddsView: UIButton {

    // MARK: Properties
    private let oddLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .backColor
        label.font = UIFont(name: "Roboto-Bold", size: 16)
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
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
            containerView.backgroundColor = isSelected ? UIColor.blue : UIColor.white
            setNeedsDisplay()
        }
    }
    
    // MARK: Functions
    private func commonInit() {
        backgroundColor = .clear
        addSubview(views: containerView)
        containerView.fill(.all)
        
        containerView.addSubview(oddLabel)
        oddLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        oddLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        oddLabel.fill(.all, constant: 5)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(asd))
        oddLabel.addGestureRecognizer(tap)
    }
    
    @objc func asd() {
        delegate?.didTapView(self.tag)
        isSelected.toggle()
    }
    
    func configure(_ odd: Double?) {
        guard let odd = odd else { return }
        oddLabel.text = "\(odd)"
    }
}
