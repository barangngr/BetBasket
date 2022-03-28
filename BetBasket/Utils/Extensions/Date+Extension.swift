//
//  Date+Extension.swift
//  BetBasket
//
//  Created by Baran Gungor on 28.03.2022.
//

import Foundation

extension Date {
    
    func toString(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}
