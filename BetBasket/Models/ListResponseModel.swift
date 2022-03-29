//
//  ListResponseModel.swift
//  BetBasket
//
//  Created by Baran Gungor on 24.03.2022.
//

import Foundation

struct ListResponseModel: Codable {
    
    let key: String?
    let group: String?
    let title: String?
    let description: String?
    let active: Bool?
    let hasOutrights: Bool?
    
    enum CodingKeys: String, CodingKey {
        case key
        case group
        case title
        case description
        case active
        case hasOutrights = "has_outrights"
    }
    
}
