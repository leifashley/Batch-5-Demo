//
//  UISearchListViewPresenter.swift
//  Batch 5 Demo
//
//  Created by Rockford Wei on 2022-03-08.
//

import UIKit

protocol UISearchListViewPresenter: UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    func assign(interactor: UISearchListViewInteractor)
    func assignNavigationController(navigationController: UINavigationController)
    func getTableCellClass() -> AnyClass
    func getTableCellId() -> String
    func getTitle() -> String
    func setTableView(tableView: UITableView)
}
