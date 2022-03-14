//
//  Repository.swift
//  Batch 5 Demo
//
//  Created by Leif Ashley on 3/11/22.
//

import Foundation
import Combine

protocol Repository {
    associatedtype RepositoryType

    func getAll(searchString: String?, completion: @escaping ([RepositoryType]) -> ())
    func get( identifier:Int ) -> RepositoryType?
    func create( a:RepositoryType ) -> Bool
    func update( a:RepositoryType ) -> Bool
    func delete( a:RepositoryType ) -> Bool

}

class NewsItemsRespository: Repository {
    typealias RepositoryType = NewsItem
    
    struct FindNewsItemsRequest: Request {
        typealias ReturnType = [NewsItem]
        var path: String = "/" + Constants.Network.apiVersion + "/" + Constants.Network.apiNews
        var queryItems: [URLQueryItem]?
    }
    
    //TODO: need to clear this out to prevent memory creep, but the method for doing so is mixed, resolve later
    public var cancellable: AnyCancellable?
    
    public func getAll(searchString: String? = nil, completion: @escaping ([NewsItem]) -> ()) {
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
//                print("- receiveSubscription")
//            }, receiveOutput: { value in
//                print("- receiveOutput")
//            }, receiveCompletion: { _ in
//                print("- receiveCompletion")
//            }, receiveCancel: {
//                print("- receiveCancel")
//            }, receiveRequest: { demand in
//                print("- receiveRequest")
//            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                print("receiveCompletion: \(completion)")
            }, receiveValue: { newItems in
                print("newItems count: \(newItems.count)")
                completion(newItems)
            })
    }
    
    func get(identifier: Int) -> NewsItem? {
        print("Error - not implemented")
        return nil
    }
    
    func create(a: NewsItem) -> Bool {
        print("Error - not implemented")
        return false
    }
    
    func update(a: NewsItem) -> Bool {
        print("Error - not implemented")
        return false
    }
    
    func delete(a: NewsItem) -> Bool {
        print("Error - not implemented")
        return false
    }
}
