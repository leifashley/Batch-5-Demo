//
//  NewsListViewInteractor.swift
//  Batch 5 Demo
//
//  Created by Rockford Wei on 2022-03-09.
//

import Combine
import UIKit

class NewsListViewInteractor: UISearchListViewInteractor {
    let title = "NewsListViewInteractor"
    
    public var repo: NewsItemsRespository? = nil
    private var router: UISearchListViewRouter? = nil
    
    func setup(repository: NewsItemsRespository) {
        self.repo = repository
    }
    
    func assign(router: UISearchListViewRouter) {
        self.router = router
    }
    
    func getNewsItems(searchString: String? = nil, completion: @escaping ([NewsItem]) -> ()) {
        if let repo = repo {
            repo.getAll(searchString: searchString) { newsItems in
                completion(newsItems)
            }
        } else {
            log.error(title: "", "repo was nil", error: AppError.unknownError)
        }
    }    
    
    func makeRoute(model: Any) -> UIViewController? {
        let ftitle = "\(className(NewsListViewInteractor.self, function: #function))"
        
        guard let router = router else {
            log.error(title: ftitle, "no router available, but it should have been set", error: AppError.unknownError)
            return UIViewController()
        }
        
        guard let detailController = router.makeDetailViewController(model: model) else {
            log.error(title: ftitle, "No detail controller", error: AppError.unknownError)
            return  nil
        }
        
        return detailController
    }
}


