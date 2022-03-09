//
//  ListingService.swift
//  Batch 5 Demo
//
//  Created by Rockford Wei on 2022-03-08.
//

import Combine
protocol ListingService {
    func getList<T: Decodable>(keywords: String?, start: Int, limit: Int,
                               entityType: T.Type,
                               completion: @escaping ([T]) -> ()) -> AnyCancellable?
}
