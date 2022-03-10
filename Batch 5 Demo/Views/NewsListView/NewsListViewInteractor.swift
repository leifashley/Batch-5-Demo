//
//  NewsListViewInteractor.swift
//  Batch 5 Demo
//
//  Created by Rockford Wei on 2022-03-09.
//

import Combine
import UIKit

class NewsListViewInteractor: NSObject, UISearchListViewInteractor {
    private var service: ListingService? = nil
    private var router: UISearchListViewRouter? = nil
    
    func setup(service: ListingService) {
        self.service = service
    }
    
    func assign(router: UISearchListViewRouter) {
        self.router = router
    }
    
    func assignListingServiceReaction<T: Decodable>
        (keywords: String?, start: Int, limit: Int, entityType: T.Type,
         completion: @escaping ([T]) -> ()) -> AnyCancellable? {
        return service?.getList(keywords: keywords, start: start, limit: limit, entityType: entityType, completion: completion)
    }
    
    func makeRoute(model: Any) -> UIViewController {
        guard let router = router else {
            fatalError("critical: no router available")
        }
        
        return router.makeDetailViewController(model: model)
    }
}
