//
//  ListViewController.swift
//  BetBasket
//
//  Created by Baran Gungor on 23.03.2022.
//

import UIKit

final class ListViewController: UIViewController {
    
    // MARK: Properties
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ListViewTableViewCell.self, forCellReuseIdentifier: "listViewTableViewCell")
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.contentInset.top = 5
        return tableView
    }()
    
    private let searchView: UISearchBar = {
        let view = UISearchBar()
        view.searchBarStyle = .minimal
        view.placeholder = "Search Event"
        view.tintColor = .descpColor
        view.searchTextField.textColor = .headerColor
        return view
    }()
    
    private var dataSource = [ListResponseModel]()
    private var viewModel = ListViewModel()
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backColor
        tableView.dataSource = self
        tableView.delegate = self
        searchView.delegate = self
        viewModel.delegate = self
        
        hideKeyboardWhenTappedAround()
        showActivityIndicator()
        viewModel.fetchEvents()
        configureViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AnalyticsManager.shared.trackScreen(event: .eventList)
        setNavColors(.navColor, textColor: .white)
        title = "Events"
    }
    
    // MARK: Functions
    private func configureViews() {
        view.addSubview(views: searchView, tableView)
        searchView.fill(.horizontal)
        searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        tableView.fill(.horizontal)
        tableView.topAnchor.constraint(equalTo: searchView.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func reloadTableView() {
        hideActivityIndicator()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

// MARK: - Extension
extension ListViewController: ListViewModelDelegate {
    func didFetchEvents(_ data: [ListResponseModel]) {
        dataSource = data
        reloadTableView()
    }
    
    func showError(_ error: Error) {
        showAlert(error.localizedDescription)
    }
}

extension ListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchBarResponse(searchText)
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listViewTableViewCell", for: indexPath as IndexPath) as! ListViewTableViewCell
        cell.configure(dataSource[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = dataSource[indexPath.row]
        AnalyticsManager.shared.track(event: .eventDetail, param: [.id: event.key ?? ""])
        let vc = EventDetailViewController(event)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

