//
//  UISearchListView.swift
//  Batch 5 Demo
//
//  Created by Rockford Wei on 2022-03-08.
//
import UIKit

class UISearchListViewController: UIViewController {
    
    static let storyboardId = String(describing: UISearchListViewController.self)
    public var presenter: UISearchListViewPresenter? = nil
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let p = presenter {
            navigationItem.title = p.getTitle()
            searchBar.delegate = p
            tableView.delegate = p
            tableView.dataSource = p
            tableView.register(p.getTableCellClass(), forCellReuseIdentifier: p.getTableCellId())
            
            if let nav = navigationController {
                p.assignNavigationController(navigationController: nav)
            }
            
            p.setTableView(tableView: tableView)
        }
    }
}
