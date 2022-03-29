//
//  WinnerTableViewCell.swift
//  BetBasket
//
//  Created by Baran Gungor on 29.03.2022.
//

import UIKit

class WinnerTableViewCell: BaseTableViewCell {
    
    // MARK: Properties
    private let oddStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 8
        return view
    }()
    
    weak var delegate: OddsTableViewCellDelegate?
    var model: OddsResponseModel?
    
    // MARK: Functions
    override func commonInit() {
        super.commonInit()
        containerView.addSubview(views: oddStack)
        
        oddStack.fill(.vertical, constant: 10)
        oddStack.fill(.horizontal, constant: 15)
    }
    
    func configure(_ model: OddsResponseModel?) {
        guard let model = model else { return }
        self.model = model
        
        oddStack.subviews.forEach({$0.removeFromSuperview()})
        
        let outcomes = model.bookmakers?.first?.markets?.first?.outcomes
        outcomes?.enumerated().forEach({
            let oddView = WinnerOddView()
            oddView.delegate = self
            oddView.tag = $0
            oddView.isUserInteractionEnabled = true
            oddStack.addArrangedSubview(oddView)
            oddView.configure($1)
        })
        
        if OddsManager.shared.oddSource.contains(where: { $0.oddModel?.id == model.id }) {
            oddStack.arrangedSubviews.forEach({
                let oddsView = ($0 as? OddsView)
                let selectedOdd = OddsManager.shared.oddSource.filter({ $0.oddModel?.id == model.id }).first?.selectedOdd
                oddsView?.isSelected = selectedOdd == oddsView?.odd
            })
        }
    }
}

// MARK: - Extension
extension WinnerTableViewCell: OddsViewDelegate {
    func didTapView(_ tag: Int, odd: Double) {
        delegate?.didSelectOdd(model, odd: odd)
        oddStack.arrangedSubviews.forEach({
            if ($0 as? OddsView)?.tag != tag {
                ($0 as? OddsView)?.isSelected = false
            }
        })
    }
}
