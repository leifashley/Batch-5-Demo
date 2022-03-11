//
//  NewsListItemViewRouter.swift
//  Batch 5 Demo
//
//  Created by qiaoliwen on 2022/3/11.
//

import Foundation
import UIKit

class NewsListItemViewRouter {
    
    func createNewsItem(tableView: UITableView, indexPath: IndexPath, newsItem: NewsItem) -> NewsListItemView{
        let presenter = NewsListItemViewPresenter()
        let interactor = NewsListItemViewInteractor()
        presenter.assign(interactor: interactor)
        presenter.assign(router: self)
        interactor.assign(newsItem: newsItem)
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListItemView", for: indexPath) as! NewsListItemView
        cell.selectionStyle = .none
        presenter.view = cell
        cell.presenter = presenter
        cell.showNewsItem()
        return cell
    }
}
