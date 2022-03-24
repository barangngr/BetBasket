//
//  OddsAPI.swift
//  BetBasket
//
//  Created by Baran Gungor on 24.03.2022.
//

import Alamofire

enum OddsAPI: BaseAPI {
    
    case lists
    case odds(String)
    case scores(String)
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .lists:                        return "/v4/sports"
        case .odds(let sport):              return "/v4/sports/" + sport + "/odds"
        case .scores(let sport):            return "/v4/sports/" + sport + "/scores"
        }
    }
    
}
