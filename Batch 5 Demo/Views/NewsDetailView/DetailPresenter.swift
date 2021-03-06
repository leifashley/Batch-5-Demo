//
//  DetailPresenter.swift
//  Batch 5 Demo
//
//  Created by Eric on 3/8/22.
//

import Foundation

class DetailPresenter {
    var view = NewsDetailView()
    var interactor = DetailInteractor()
    var router: DetailRouter
    
    init(router: DetailRouter) {
        self.router = router
    }
    
    func showArticleWith(articleID: Int) {
        view.newsItem = interactor.getNewsItem(articleID: articleID)
        self.router.navigationController.present(self.view, animated: true)
    }
}
