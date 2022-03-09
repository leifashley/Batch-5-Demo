//
//  UISearchListView.swift
//  Batch 5 Demo
//
//  Created by Rockford Wei on 2022-03-08.
//
import UIKit

class UISearchListViewController: UIViewController {
    
    static let storyboardId = String(describing: UISearchListViewController.self)
    var presenter: UISearchListViewPresenter? = nil
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = presenter?.getTitle()
    }
}
