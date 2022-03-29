//
//  EventDetailViewModel.swift
//  BetBasket
//
//  Created by Baran Gungor on 28.03.2022.
//

import Foundation

protocol EventDetailViewModelDelegate: AnyObject {
    func didFetchOdds(_ data: [OddsResponseModel])
    func showError(_ error: Error)
}

final class EventDetailViewModel {
    
    // MARK: Properties
    weak var delegate: EventDetailViewModelDelegate?
    
    // MARK: Functions
    func fetchOdds(_ model: ListResponseModel?) {
        guard let model = model, let key = model.key else { return }
        // I prefered eu as the region to avoid complex structure in UI.
        NetworkManager.shared.sendRequest(model: OddsAPI.odds(key), parameters: ["regions": "eu"],
                                          type: [OddsResponseModel].self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.delegate?.didFetchOdds(response)
            case .failure(let error):
                self.delegate?.showError(error)
            }
        }
    }
    
}
