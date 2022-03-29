//
//  CartListViewController.swift
//  BetBasket
//
//  Created by Baran Gungor on 29.03.2022.
//

import UIKit

final class CartListViewController: UIViewController {
    
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
    
    private var dataSource = OddsManager.shared.oddSource
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backColor
        tableView.dataSource = self
        tableView.delegate = self
        
        configureViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AnalyticsManager.shared.trackScreen(event: .cartList)
        setNavColors(.navColor, textColor: .white)
        title = "Odds in Basket"
        setNavBackButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reloadTableView()
    }
    
    // MARK: Functions
    private func configureViews() {
        view.addSubview(views: tableView)
        tableView.fill(.all)
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

// MARK: - Extension
extension CartListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // It was intentionally closed (contentView.isUserInteractionEnabled) because there was no time to build a more complex structure.
        if dataSource[indexPath.row].oddModel?.homeTeam != nil {
            let cell = tableView.dequeueReusableCell(withIdentifier: "oddsTableViewCell", for: indexPath as IndexPath) as! OddsTableViewCell
            cell.configure(dataSource[indexPath.row].oddModel)
            cell.selectionStyle = .none
            cell.contentView.isUserInteractionEnabled = false
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "winnerTableViewCell", for: indexPath as IndexPath) as! WinnerTableViewCell
            cell.configure(dataSource[indexPath.row].oddModel)
            cell.selectionStyle = .none
            cell.contentView.isUserInteractionEnabled = false
            return cell
        }
    }
    
}
