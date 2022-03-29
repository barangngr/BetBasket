//
//  OddsResponseModel.swift
//  BetBasket
//
//  Created by Baran Gungor on 24.03.2022.
//

import Foundation

struct OddsResponseModel: Codable {
    
    let id: String?
    let sportKey: String?
    let commenceTime: String?
    let homeTeam: String?
    let awayTeam: String?
    let bookmakers: [BookmakerModel]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case sportKey = "sport_key"
        case commenceTime = "commence_time"
        case homeTeam = "home_team"
        case awayTeam = "away_team"
        case bookmakers
    }
    
}

// MARK: BookmakerResponseModel
struct BookmakerModel: Codable {
    
    let key: String?
    let title: String?
    let lastUpdate: String?
    let markets: [MarketModel]?

    enum CodingKeys: String, CodingKey {
        case key
        case title
        case lastUpdate = "last_update"
        case markets
    }
    
}

// MARK: MarketResponseModel
struct MarketModel: Codable {
    let key: String?
    let outcomes: [OutcomeModel]?
}

// MARK: MarketResponseModel
struct OutcomeModel: Codable {
    let name: String?
    let price: Double?
}
