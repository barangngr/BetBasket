//
//  BaseErrorModel.swift
//  BetBasket
//
//  Created by Baran Gungor on 24.03.2022.
//

struct BaseErrorModel: Codable {
    
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case message
    }
    
}
