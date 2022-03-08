//
//  UISearchListView.swift
//  Batch 5 Demo
//
//  Created by Rockford Wei on 2022-03-08.
//
import UIKit

class UISearchListViewController: UIViewController {
    
    var presenter: UISearchListViewPresenter? = nil
    
    private let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.searchTextField.keyboardType = .numberPad
        return bar
    }()
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    private func setupLayout() {
        searchBar.delegate = presenter?.getSearchDelegate()
        tableView.delegate = presenter?.getTableDelegate()
        tableView.dataSource = presenter?.getTableSource()
        view.backgroundColor = .systemBackground
        view.addSubview(searchBar)
        view.addSubview(tableView)
        if let cellClass = presenter?.getTableCellClass(),
           let cellId = presenter?.getTableCellId() {
            tableView.register(cellClass, forCellReuseIdentifier: cellId)
        }
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 48),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = presenter?.getTitle()
        setupLayout()
    }
}
