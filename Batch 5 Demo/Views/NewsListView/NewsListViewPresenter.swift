//
//  NewsListViewPresenter.swift
//  Batch 5 Demo
//
//  Created by Rockford Wei on 2022-03-09.
//
import Combine
import UIKit

class NewsListViewPresenter: NSObject, UISearchListViewPresenter {
    
    let cellId = UUID().uuidString
    private var router: UISearchListViewRouter? = nil
    private var navigationController: UINavigationController? = nil
    var items: [NewsItemModel] = []
    func assignNavigationController(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func assignDetailViewRouter (router: UISearchListViewRouter) {
        self.router = router
    }
    
    func getSearchDelegate() -> UISearchBarDelegate {
        fatalError("TODO")
    }
    
    func getTableSource() -> UITableViewDataSource {
        return self
    }
    
    func getTableDelegate() -> UITableViewDelegate {
        return self
    }
    
    func getTableCellClass() -> AnyClass {
        return NewsListItemView.self
    }
    
    func getTableCellId() -> String {
        return cellId
    }
    
    func getTitle() -> String {
        return R.string("NewsTitle")
    }
}

extension NewsListViewPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return NewsListItemView.cellHeight
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        if let viewController = router?.makeDetailViewController(id: item.id) {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
extension NewsListViewPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NewsListItemView
        if let xcell = tableView.dequeueReusableCell(withIdentifier: cellId) as? NewsListItemView {
            cell = xcell
        } else {
            cell = NewsListItemView(style: .default, reuseIdentifier: cellId)
        }
        cell.model = items[indexPath.row]
        return cell
    }
}
