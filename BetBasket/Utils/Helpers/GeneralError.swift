//
//  GeneralError.swift
//  BetBasket
//
//  Created by Baran Gungor on 23.03.2022.
//

import Foundation

enum GeneralError: Error {
    case invalidURL
    case invalidData
    case unexpected(Int, String)
}

extension GeneralError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:                           return "Invalid URL, please try again later."
        case .invalidData:                          return "Invalid Data, please try again later."
        case .unexpected(let code, let message):    return "Message: \(message), statsuCode: \(code)" 
        }
    }
}
