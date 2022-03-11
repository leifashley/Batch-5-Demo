//
//  NewsListItemViewPresenter.swift
//  Batch 5 Demo
//
//  Created by qiaoliwen on 2022/3/11.
//

import Foundation

class NewsListItemViewPresenter {
    
    weak var view : NewsListItemView? = nil
    private var router: NewsListItemViewRouter? = nil
    private var interactor: NewsListItemViewInteractor? = nil

    func assign(router: NewsListItemViewRouter) {
        self.router = router
    }
    
    func assign(interactor: NewsListItemViewInteractor) {
        self.interactor = interactor
    }
    
    func loadNewsItem(){
        if let newsItem = interactor?.getNewsItemModel() {
            view?.configure(model: newsItem)
        }
    }
}
