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
        tableView.register(WinnerTableViewCell.self, forCellReuseIdentifier: "winnerTableViewCell")
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.contentInset.top = 5
        return tableView
    }()
    
    private let basketView: BasketView = {
        let view = BasketView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        basketView.delegate = self
        
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
        view.addSubview(views: tableView, basketView)
        tableView.fill(.all)
        
        basketView.heightAnchor.constraint(equalToConstant: 65).isActive = true
        basketView.widthAnchor.constraint(equalToConstant: 65).isActive = true
        basketView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        basketView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -35).isActive = true
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
        basketView.configure()
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
        if eventModel?.hasOutrights ?? false {
            let cell = tableView.dequeueReusableCell(withIdentifier: "winnerTableViewCell", for: indexPath as IndexPath) as! WinnerTableViewCell
            cell.configure(dataSource[indexPath.row])
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "oddsTableViewCell", for: indexPath as IndexPath) as! OddsTableViewCell
        cell.configure(dataSource[indexPath.row])
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
}

extension EventDetailViewController: OddsTableViewCellDelegate {
    func didSelectOdd(_ model: OddsResponseModel?, odd: Double) {
        OddsManager.shared.handleOdd(model, odd: odd)
        basketView.configure()
    }
}

extension EventDetailViewController: BasketViewDelegate {
    func didTapView() {
        let vc = CartListViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
