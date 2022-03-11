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
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchBgView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        self.view.backgroundColor = .appBackgroundColor
        searchBgView.layer.masksToBounds = true
        searchBgView.layer.cornerRadius = 20
        searchBgView.layer.borderWidth = 2
        searchBgView.layer.borderColor = UIColor.splinesColor?.cgColor
        
        searchBar.searchTextField.backgroundColor = .clear
        
        if let p = presenter {
            navigationItem.title = p.getTitle()
            searchBar.delegate = p
            tableView.delegate = p
            tableView.dataSource = p
//            tableView.register(p.getTableCellClass(), forCellReuseIdentifier: p.getTableCellId())
            
            if let nav = navigationController {
                p.assignNavigationController(navigationController: nav)
            }
            
            p.setTableView(tableView: tableView)
        }
    }
}
