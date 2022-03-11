//
//  NewsListItemViewPresenter.swift
//  Batch 5 Demo
//
//  Created by qiaoliwen on 2022/3/11.
//

import Foundation

class NewsListItemViewPresenter {
    
    var router: NewsListItemViewRouter?
    weak var view : NewsListItemView?
    var interactor: NewsListItemViewInteractor?
    var newsItem: NewsItem?
    
    func getNewsItemFromInteractor(){
        interactor?.getNewsItem(newItem: nil)
    }
    
    func configureView(view: NewsListItemView){
        view.presenter.view = view
        view.presenter.router = NewsListItemViewRouter()
        view.presenter.interactor = NewsListItemViewInteractor()
        view.presenter.interactor?.presenter = view.presenter
    }
}

extension NewsListItemViewPresenter: NewsListItemViewOutputInteractorProtocal {
    func didGetNewItem(newsItem: NewsItem) {
        view?.configure(model: newsItem)
    }
}
