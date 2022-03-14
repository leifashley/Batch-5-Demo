//
//  NewsListItemViewRouter.swift
//  Batch 5 Demo
//
//  Created by qiaoliwen on 2022/3/11.
//

import Foundation
import UIKit

class NewsListItemViewRouter {
    
    func createNewsItem(tableView: UITableView, indexPath: IndexPath, newsItem: NewsItem) -> UITableViewCell {
        let presenter = NewsListItemViewPresenter()
        let interactor = NewsListItemViewInteractor()
        
        presenter.assign(interactor: interactor)
        presenter.assign(router: self)
        interactor.assign(newsItem: newsItem)
        
        var cell: NewsListItemView?
        if let c = tableView.dequeueReusableCell(withIdentifier: "NewsListItemView", for: indexPath) as? NewsListItemView {
            cell = c
            
            c.selectionStyle = .none
            presenter.view = c
            c.presenter = presenter
            c.showNewsItem()
        }
        
        return cell ?? UITableViewCell()
    }
}
