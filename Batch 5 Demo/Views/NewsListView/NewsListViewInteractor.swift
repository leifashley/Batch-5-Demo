//
//  NewsListViewInteractor.swift
//  Batch 5 Demo
//
//  Created by Rockford Wei on 2022-03-09.
//

import Combine
import UIKit

class NewsListViewInteractor: UISearchListViewInteractor {
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
            print("ERROR: repo was nil")
        }
    }    
    
    func makeRoute(model: Any) -> UIViewController? {
        guard let router = router else {
            fatalError("critical: no router available")
        }
        
        guard let detailController = router.makeDetailViewController(model: model) else {
            print("No detail controller")
            return  nil
        }
        
        return detailController
    }
}
