//
//  ListViewModel.swift
//  BetBasket
//
//  Created by Baran Gungor on 23.03.2022.
//

import Foundation

final class ListViewModel {
    
    //        NetworkManager.shared.sendRequest(model: OddsAPI.lists, type: [ListResponseModel].self) { result in
    //            switch result {
    //            case .success(let response):
    //                print(response.first)
    //            case .failure(let error):
    //                print(error)
    //            }
    //        }
    
    NetworkManager.shared.sendRequest(model: OddsAPI.odds("soccer_denmark_superliga"), parameters: ["regions": "eu"],
                                      type: [OddsResponseModel].self) { result in
        switch result {
        case .success(let response):
            print(response)
        case .failure(let error):
            print(error)
        }
        
    }
    
}
