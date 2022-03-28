//
//  EventDetailViewController.swift
//  BetBasket
//
//  Created by Baran Gungor on 28.03.2022.
//

import UIKit

final class EventDetailViewController: UIViewController {
    
    // MARK: Properties
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(OddsTableViewCell.self, forCellReuseIdentifier: "oddsTableViewCell")
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.contentInset.top = 5
        return tableView
    }()
    
    private var eventModel: ListResponseModel?
    private var dataSource = [OddsResponseModel]()
    private var viewModel = EventDetailViewModel()
    
    // MARK: Initiliaze
    convenience init(_ model: ListResponseModel) {
        self.init()
        eventModel = model
    }
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backColor
        tableView.dataSource = self
        tableView.delegate = self
        viewModel.delegate = self
        
        showActivityIndicator()
        viewModel.fetchOdds(eventModel)
        configureViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AnalyticsManager.shared.trackScreen(event: .eventDetail)
        setNavColors(.navColor, textColor: .white)
        title = eventModel?.title
        setNavBackButton()
    }
    
    // MARK: Functions
    private func configureViews() {
        view.addSubview(views: tableView)
        tableView.fill(.all)
    }
    
    private func reloadTableView() {
        hideActivityIndicator()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

// MARK: - Extension
extension EventDetailViewController: EventDetailViewModelDelegate {
    func didFetchOdds(_ data: [OddsResponseModel]) {
        dataSource = data
        reloadTableView()
    }
    
    func showError(_ error: Error) {
        showAlert(error.localizedDescription)
    }
}

extension EventDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "oddsTableViewCell", for: indexPath as IndexPath) as! OddsTableViewCell
        cell.configure(dataSource[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
}


