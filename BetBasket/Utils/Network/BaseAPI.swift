//
//  BaseAPI.swift
//  BetBasket
//
//  Created by Baran Gungor on 24.03.2022.
//

import Alamofire

protocol BaseAPI {
    var method: HTTPMethod { get }
    var path: String { get }
}
