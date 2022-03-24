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
    
    enum CodingKeys: String, CodingKey {
        case id
        case sportKey = "sport_key"
        case commenceTime = "commence_time"
        case homeTeam = "home_team"
        case awayTeam = "away_team"
    }
    
}
