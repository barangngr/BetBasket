//
//  AnalyticsConstants.swift
//  BetBasket
//
//  Created by Baran Gungor on 24.03.2022.
//


typealias AnalyticsParams = [AnalyticsConstants: Any]?

enum AnalyticsConstants: String {
    case id
    case key
    case amount
    case errorCode
    case type
    
    var value: String {
        self.rawValue.camelCaseToSnakeCase()
    }
}
