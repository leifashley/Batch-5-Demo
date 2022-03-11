//
//  NewsListItemService.swift
//  Batch 5 Demo
//
//  Created by Rockford Wei on 2022-03-08.
//

import Combine
import Foundation


//class NewsListItemService {
//    let session: URLSession
//    let io: DispatchQueue
//    
//    init(session s: URLSession = URLSession.shared, io: DispatchQueue = .main) {
//        session = s; self.io = io
//    }
//    
//    func getItem<T: Decodable>(id: Int, placeholder: T, completion: @escaping (T) -> ()) -> AnyCancellable? {
//        let urlString = Constants.Network.apiNewsListItem(id: id)
//        
//        guard let url = URL(string: urlString) else {
//            NSLog("rare exception: invalid url for \(urlString)")
//            return nil
//        }
//        
//        let decoder = JSONDecoder()
//        decoder.dateDecodingStrategy = .custom(Date.iso8601Adaptive)
//       
//        return session.dataTaskPublisher(for: url).tryMap { $0.data }
//        .decode(type: T.self, decoder: decoder)
//        .replaceError(with: placeholder)
//        .receive(on: io)
//        .sink(receiveValue: completion)
//    }
//    
//    static let shared = NewsListItemService()
//}
