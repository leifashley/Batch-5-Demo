//
//  NewsListViewInteractor.swift
//  Batch 5 Demo
//
//  Created by Rockford Wei on 2022-03-09.
//

import Combine
import UIKit

struct NewsListViewInteractor: UISearchListViewInteractor {
    private let service: ListingService
    private let router: UISearchListViewRouter
    init(service: ListingService, router: UISearchListViewRouter) {
        self.service = service
        self.router = router
    }
    func assignListingServiceReaction<T: Decodable>
        (keywords: String?, start: Int, limit: Int, entityType: T.Type,
         completion: @escaping ([T]) -> ()) -> AnyCancellable? {
        service.getList(keywords: keywords, start: start, limit: limit, entityType: entityType, completion: completion)
    }
    func makeRoute(id: Int) -> UIViewController {
        return router.makeDetailViewController(id: id)
    }
}
