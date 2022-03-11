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
    
    var items: [NewsItem] = []
    
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
        return "ViewTitle-News".localized()
    }
    
    func setTableView(tableView: UITableView) {
        self.tableView = tableView
        handler = interactor?.assignListingServiceReaction(keywords: nil, start: -1, limit: pageSize, entityType: NewsItem.self) { entries in
            self.items = entries
            self.tableView?.reloadData()
        }
    }
}

extension NewsListViewPresenter: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        handler = interactor?.assignListingServiceReaction(keywords: searchText, start: -1, limit: pageSize, entityType: NewsItem.self) { entries in
            self.items = entries
            self.tableView?.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

extension NewsListViewPresenter: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return NewsListItemView.cellHeight
//    }
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
//        let cell: NewsListItemView
//        if let xcell = tableView.dequeueReusableCell(withIdentifier: "NewsListItemView") as? NewsListItemView {
//            cell = xcell
//        } else {
//            cell = NewsListItemView(style: .default, reuseIdentifier: "NewsListItemView")
//        }
//        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListItemView", for: indexPath) as! NewsListItemView
//        cell.selectionStyle = .none
//        cell.configure(model: items[indexPath.row])
        return NewsListItemViewRouter().createNewsItem(tableView: tableView, indexPath: indexPath, newsItem: items[indexPath.row])
    }
}
