//
//  NewsListItemViewRouter.swift
//  Batch 5 Demo
//
//  Created by qiaoliwen on 2022/3/11.
//

import Foundation
import UIKit

class NewsListItemViewRouter {
    func createNewsItem(tableView: UITableView, indexPath: IndexPath) -> NewsListItemView{
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListItemView", for: indexPath) as! NewsListItemView
        cell.selectionStyle = .none
        let presenter = NewsListItemViewPresenter()
        let interactor = NewsListItemViewInteractor()
        let router = NewsListItemViewRouter()
        cell.presenter = presenter
        presenter.view = cell
        presenter.interactor = interactor
        presenter.router = router
        return cell
    }
}
