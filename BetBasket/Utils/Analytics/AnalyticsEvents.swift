//
//  AnalyticsEvents.swift
//  BetBasket
//
//  Created by Baran Gungor on 24.03.2022.
//

import Foundation

// MARK: AnalyticsScreenEvent
enum AnalyticsScreenEvent: String {
    case eventList
    case eventDetail
    case cartList
}

// MARK: AnalyticsEvent
enum AnalyticsEvent: String {
    
    case eventDetail
    case addCart
    case removeCart
    case etcEvent
    
    var value: String {
        self.rawValue.camelCaseToSnakeCase()
    }
    
}
