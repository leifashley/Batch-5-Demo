//
//  NewsListingService.swift
//  Batch 5 Demo
//
//  Created by Rockford Wei on 2022-03-08.
//

import Combine
import Foundation

class NewsListCountService: ListCountService {
    let session: URLSession
    let io: DispatchQueue
    init(session s: URLSession = URLSession.shared, io: DispatchQueue = .main) {
        session = s; self.io = io
    }
    func getListCount(completion: @escaping (Int)->() ) -> AnyCancellable? {
        let urlString = Constants.Network.apiNewsListCount
        guard let url = URL(string: urlString) else {
            return nil
        }
        return session.dataTaskPublisher(for: url)
            .tryMap { $0.data }
            .decode(type: Int.self, decoder: JSONDecoder())
            .replaceError(with: -1)
            .receive(on: self.io)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    NSLog("completed: apiNewsCount")
                case .failure:
                    NSLog("failed: apiNewsCount")
                }
            }, receiveValue: completion)
    }
    static let shared = NewsListCountService()
}
