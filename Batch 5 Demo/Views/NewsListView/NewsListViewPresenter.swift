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
    let pageSize = 100
    private var interactor: UISearchListViewInteractor? = nil
    private var navigationController: UINavigationController? = nil
    private var handler: AnyCancellable? = nil
    private var tableView: UITableView? = nil
    var items: [NewsItemModel] = []
    func assignNavigationController(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func assign(interactor: UISearchListViewInteractor) {
        self.interactor = interactor
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
    func setTableView(tableView: UITableView) {
        self.tableView = tableView
        handler = interactor?.assignListingServiceReaction(keywords: nil, start: -1, limit: pageSize, entityType: NewsItemModel.self) { entries in
            self.items = entries
            self.tableView?.reloadData()
        }
    }
}
extension NewsListViewPresenter: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        handler = interactor?.assignListingServiceReaction(keywords: searchText, start: -1, limit: pageSize, entityType: NewsItemModel.self) { entries in
            self.items = entries
            self.tableView?.reloadData()
        }
    }
}
extension NewsListViewPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return NewsListItemView.cellHeight
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        if let viewController = interactor?.makeRoute(model: item) {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
extension NewsListViewPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableView = tableView
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
