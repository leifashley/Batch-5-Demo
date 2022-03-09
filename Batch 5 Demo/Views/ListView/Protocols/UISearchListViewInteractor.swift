//
//  UISearchListViewInteractor.swift
//  Batch 5 Demo
//
//  Created by Rockford Wei on 2022-03-08.
//

import Combine
import UIKit

protocol UISearchListViewInteractor {
    init(service: ListingService, router: UISearchListViewRouter)
    func assignListingServiceReaction<T: Decodable>
        (keywords: String?, start: Int, limit: Int, entityType: T.Type,
         completion: @escaping ([T]) ->()) -> AnyCancellable?
    func makeRoute(id: Int) -> UIViewController
}
