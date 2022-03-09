//
//  NewsListingService.swift
//  Batch 5 Demo
//
//  Created by Rockford Wei on 2022-03-08.
//

import Combine
import Foundation


class NewsListingService: ListingService {
    let session: URLSession
    let io: DispatchQueue
    init(session s: URLSession = URLSession.shared, io: DispatchQueue = .main) {
        session = s; self.io = io
    }
    func getList<T: Decodable>(keywords: String?, start: Int = -1, limit: Int = -1,
                               entityType: T.Type,
                               completion: @escaping ([T]) -> ()) -> AnyCancellable? {
        var parameters:[String: String] = [:]
        if let keywords = keywords {
            parameters["summary_contains"] = keywords
        }
        if start >= 0 {
            parameters["_start"] = "\(start)"
        }
        if limit >= 0 {
            parameters["_limit"] = "\(limit)"
        }
        let urlString = Constants.Network.apiNewsListing(parameters: parameters)
        guard let url = URL(string: urlString) else {
            NSLog("rare exception: invalid url for \(urlString)")
            return nil
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(Date.iso8601Adaptive)
        return session.dataTaskPublisher(for: url)
            .tryMap { $0.data }
        .decode(type: [T].self, decoder: decoder)
        .replaceError(with: [])
        .receive(on: io)
        .sink(receiveValue: completion)
    }
}
