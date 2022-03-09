//
//  UISearchListViewPresenter.swift
//  Batch 5 Demo
//
//  Created by Rockford Wei on 2022-03-08.
//

import UIKit

protocol UISearchListViewPresenter {
    func assignDetailViewRouter(router: UISearchListViewRouter)
    func assignNavigationController(navigationController: UINavigationController)
    func getSearchDelegate() -> UISearchBarDelegate
    func getTableSource() -> UITableViewDataSource
    func getTableDelegate() -> UITableViewDelegate
    func getTableCellClass() -> AnyClass
    func getTableCellId() -> String
    func getTitle() -> String
}
