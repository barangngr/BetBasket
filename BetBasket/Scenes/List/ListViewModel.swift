//
//  ListViewModel.swift
//  BetBasket
//
//  Created by Baran Gungor on 23.03.2022.
//

import Foundation

protocol ListViewModelDelegate: AnyObject {
    func didFetchRepos(_ data: [ListResponseModel])
    func showError(_ error: Error)
}

final class ListViewModel {
    
    // MARK: Properties
    weak var delegate: ListViewModelDelegate?
    
    // MARK: Functions
    func fetchEvents() {
        NetworkManager.shared.sendRequest(model: OddsAPI.lists, type: [ListResponseModel].self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.delegate?.didFetchRepos(response)
            case .failure(let error):
                self.delegate?.showError(error)
            }
        }
    }
    
    //    NetworkManager.shared.sendRequest(model: OddsAPI.odds("soccer_denmark_superliga"), parameters: ["regions": "eu"],
    //                                      type: [OddsResponseModel].self) { result in
    //        switch result {
    //        case .success(let response):
    //            print(response)
    //        case .failure(let error):
    //            print(error)
    //        }
    //
    //    }
    
}
