//
//  ListViewModel.swift
//  BetBasket
//
//  Created by Baran Gungor on 23.03.2022.
//

import Foundation

protocol ListViewModelDelegate: AnyObject {
    func didFetchEvents(_ data: [ListResponseModel])
    func showError(_ error: Error)
}

final class ListViewModel {
    
    // MARK: Properties
    private var mainDataSource: [ListResponseModel]?
    weak var delegate: ListViewModelDelegate?
    
    // MARK: Functions
    func fetchEvents() {
        NetworkManager.shared.sendRequest(model: OddsAPI.lists, type: [ListResponseModel].self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.mainDataSource = response
                self.delegate?.didFetchEvents(response)
            case .failure(let error):
                self.delegate?.showError(error)
            }
        }
    }
    
    func searchBarResponse(_ searchText: String) {
        // I chose to use a single delegate method because their functions are the same. But two different funcs could be defined under different naming.
        guard let mainDataSource = mainDataSource else { return }
        if searchText == "" {
            delegate?.didFetchEvents(mainDataSource)
        } else {
            delegate?.didFetchEvents(mainDataSource.filter({ $0.title?.contains(searchText.uppercased()) ?? false }))
        }
    }
    
}
