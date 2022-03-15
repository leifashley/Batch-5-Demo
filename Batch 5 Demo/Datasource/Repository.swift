//
//  Repository.swift
//  Batch 5 Demo
//
//  Created by Leif Ashley on 3/11/22.
//

import Foundation
import Combine

/// General conformation protocol for the Repository pattern CRUD
protocol Repository {
    associatedtype RepositoryType

    func getAll(searchString: String?, completion: @escaping ([RepositoryType]) -> ())
    func get( identifier:Int ) -> RepositoryType?
    func create( a: RepositoryType ) -> Bool
    func update( a: RepositoryType ) -> Bool
    func delete( a: RepositoryType ) -> Bool
}

/// NewsItem specific repo for the Spaceflight News API
class NewsItemsRespository: Repository {
    let title = "NewsItemsRespository"
    
    typealias RepositoryType = NewsItem
    
    struct FindNewsItemsRequest: Request {
        typealias ReturnType = [NewsItem]
        var path: String = "/" + Constants.Network.apiVersion + "/" + Constants.Network.apiNews
        var queryItems: [URLQueryItem]?
    }
    
    public var cancellable: AnyCancellable?
    
    
    /// Gets all the news items, defaults to 100, for spaceflight newssights.
    ///
    /// - Parameters:
    ///   - searchString: Optional search string used to filter the incoming results to those matching the searchString in the API summary_contains query string param
    ///   - completion: returns a completion result of [NewsItems], empty if none were found or an error occurred
    public func getAll(searchString: String? = nil, completion: @escaping ([NewsItem]) -> ()) {
        let ftitle = "\(title).getAll"
        let apiClient = APIClient(baseURL: Constants.Network.hostName)
        
        var request = FindNewsItemsRequest()
        request.queryItems = [URLQueryItem(name: "_limit", value: "100")]
        
        if let searchString = searchString {
            request.queryItems?.append(URLQueryItem(name: "summary_contains", value: searchString))
        }
        
        //TODO: extend publishers to add a generic way to log all this
        cancellable = apiClient.dispatch(request: request)
//            .print("newItems Request")
//            .handleEvents(receiveSubscription: { _ in
//                log.debug("- receiveSubscription")
//            }, receiveOutput: { value in
//                log.debug("- receiveOutput")
//            }, receiveCompletion: { _ in
//                log.debug("- receiveCompletion")
//            }, receiveCancel: {
//                log.debug("- receiveCancel")
//            }, receiveRequest: { demand in
//                log.debug("- receiveRequest")
//            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                log.info(title: ftitle, "receiveCompletion: \(completion)")
            }, receiveValue: { newItems in
                log.info(title: ftitle, "newItems count: \(newItems.count)")
                completion(newItems)
            })
    }
    
    /**
            Remaining CRUD items are places holders and log a "not implemented" error if called
     */
    func get(identifier: Int) -> NewsItem? {
        log.error(title: title, "get() not implemented", error: AppError.unknownError)
        return nil
    }
    
    func create(a: NewsItem) -> Bool {
        log.error(title: title, "create() not implemented", error: AppError.unknownError)
        return false
    }
    
    func update(a: NewsItem) -> Bool {
        log.error(title: title, "update() not implemented", error: AppError.unknownError)
        return false
    }
    
    func delete(a: NewsItem) -> Bool {
        log.error(title: title, "delete() not implemented", error: AppError.unknownError)
        return false
    }
}
