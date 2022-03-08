//
//  NewsListItemService.swift
//  Batch 5 Demo
//
//  Created by Rockford Wei on 2022-03-08.
//

import Combine
import Foundation

class NewsListItemService: ListItemService {
    let session: URLSession
    let io: DispatchQueue
    init(session s: URLSession = URLSession.shared, io: DispatchQueue = .main) {
        session = s; self.io = io
    }
    func getItem<T: Decodable>(id: Int, placeholder: T, completion: @escaping (T) -> ()) -> AnyCancellable? {
        let urlString = Constants.Network.apiNewsListItem(id: id)
        guard let url = URL(string: urlString) else {
            return nil
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return session.dataTaskPublisher(for: url)
            .tryMap { response in
                if let text = String(data: response.data, encoding: .utf8) {
                    print(text)
                }
                return response.data
            }
            .decode(type: [T].self, decoder: decoder)
            .replaceError(with: placeholder)
            .receive(on: self.io)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    NSLog("completed: apiNewsListItem")
                case .failure:
                    NSLog("failed: apiNewsListItem")
                }
            }, receiveValue: completion)
    }
    static let shared = NewsListItemService()
}
