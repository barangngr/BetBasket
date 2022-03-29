//
//  OddsManager.swift
//  BetBasket
//
//  Created by Baran Gungor on 29.03.2022.
//

import Foundation

final class OddsManager {
    
    // MARK:  Properties
    static var shared: OddsManager = OddsManager()
    
    var oddSource = [NewOddModel]()
    var totalOdd: Double = 1
    
    // MARK: Initiliaze
    private init() {}
    
    // MARK: Functions
    func handleOdd(_ model: OddsResponseModel?, odd: Double?) {
        guard let model = model, let odd = odd else { return }
        
        if oddSource.contains(where: {$0.oddModel?.id == model.id && $0.selectedOdd == odd}) {
            removeOdd(model, odd: odd)
        } else if oddSource.contains(where: {$0.oddModel?.id == model.id && $0.selectedOdd != odd}) {
            let oldModel = oddSource.filter({$0.oddModel?.id == model.id}).first
            let newModel = NewOddModel(oddModel: model, selectedOdd: oldModel?.selectedOdd ?? 0.0)
            changeOdd(newModel, odd: odd)
        } else {
            let newModel = NewOddModel(oddModel: model, selectedOdd: odd)
            addOdd(newModel)
        }
    }
    
    private func addOdd(_ model: NewOddModel) {
        oddSource.append(model)
        totalOdd *= model.selectedOdd
        AnalyticsManager.shared.track(event: .addCart, param: [.id: model.oddModel?.id ?? "*-",
                                                               .amount: model.selectedOdd])
    }
    
    private func removeOdd(_ model: OddsResponseModel, odd: Double) {
        oddSource = oddSource.filter({$0.oddModel?.id != model.id})
        totalOdd /= odd
        AnalyticsManager.shared.track(event: .removeCart, param: [.id: model.id ?? "*-",
                                                                  .amount: odd])
    }
    
    private func changeOdd(_ model: NewOddModel, odd: Double) {
        guard let oddModel = model.oddModel else { return }
        removeOdd(oddModel, odd: model.selectedOdd)
        let newModel = NewOddModel(oddModel: oddModel, selectedOdd: odd)
        addOdd(newModel)
    }
    
}
