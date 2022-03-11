//
//  Network.swift
//  Batch 5 Demo
//
//  Created by Leif Ashley on 3/11/22.
//

import Foundation
import Combine

enum NetworkRequestError: LocalizedError, Equatable {
    case invalidRequest
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case error4xx(_ code: Int)
    case serverError
    case error5xx(_ code: Int)
    case decodingError
    case urlSessionFailed(_ error: URLError)
    case unknownError
}

struct NetworkDispatcher {
    let urlSession: URLSession!
    
    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func dispatch<ReturnType: Codable>(request: URLRequest) -> AnyPublisher<ReturnType, NetworkRequestError> {
        print("URL Request: \(request)")
        print("Return type: \(ReturnType.self)")
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(Date.iso8601Adaptive)
        
        return urlSession.dataTaskPublisher(for: request)
//            .print("DEBUG") //debug tracking
            .tryMap({ data, response in
                if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                    print("Response Error code: \(response.statusCode)")
                    throw httpError(response.statusCode)
                }
                
                return data
            })
            .decode(type: ReturnType.self, decoder: decoder)
            .mapError { error in
                handleError(error)
            }
            // And finally, expose our publisher
            .eraseToAnyPublisher()
    }
}

extension NetworkDispatcher {
/// Parses a HTTP StatusCode and returns a proper error
    /// - Parameter statusCode: HTTP status code
    /// - Returns: Mapped Error
    private func httpError(_ statusCode: Int) -> NetworkRequestError {
        switch statusCode {
        case 400: return .badRequest
        case 401: return .unauthorized
        case 403: return .forbidden
        case 404: return .notFound
        case 402, 405...499: return .error4xx(statusCode)
        case 500: return .serverError
        case 501...599: return .error5xx(statusCode)
        default: return .unknownError
        }
    }
    
    /// Parses URLSession Publisher errors and return proper ones
    /// - Parameter error: URLSession publisher error
    /// - Returns: Readable NetworkRequestError
    private func handleError(_ error: Error) -> NetworkRequestError {
        print("ERROR: \(error)")
        
        switch error {
        case is Swift.DecodingError:
            return .decodingError
        case let urlError as URLError:
            return .urlSessionFailed(urlError)
        case let error as NetworkRequestError:
            return error
        default:
            return .unknownError
        }
    }
}

struct APIClient {
    var baseURL: String
    var networkDispatcher: NetworkDispatcher
    
    init(baseURL: String, networkDispatcher: NetworkDispatcher = NetworkDispatcher()) {
        self.baseURL = baseURL
        self.networkDispatcher = networkDispatcher
    }
    
    func dispatch<R: Request>(request: R) -> AnyPublisher<R.ReturnType, NetworkRequestError> {
        guard let urlRequest = request.asURLRequest(baseURL: baseURL) else {
            return Fail(outputType: R.ReturnType.self, failure: NetworkRequestError.badRequest).eraseToAnyPublisher()
        }
        
        typealias RequestPublisher = AnyPublisher<R.ReturnType, NetworkRequestError>
        let requestPublisher: RequestPublisher = networkDispatcher.dispatch(request: urlRequest)
        
        return requestPublisher.eraseToAnyPublisher()
    }
}

// Model
struct Todo: Codable {
   var title: String
   var completed: Bool
}

struct FindTodosRequest: Request {
     typealias ReturnType = [Todo]
     var path: String = "/todos"
}

struct FindNewsItemsRequest: Request {
    typealias ReturnType = [NewsItem]
    var path: String = "/" + Constants.Network.apiVersion + "/" + Constants.Network.apiNews
}

class MyClass {
    //TODO: need to clear this out to prevent memory creep, but the method for doing so is mixed, resolve later
    private var cancellables = [AnyCancellable]()
    
    func z2(completion: (FindNewsItemsRequest.ReturnType) -> ()) {
        let apiClient = APIClient(baseURL: Constants.Network.hostName)
        
        let request = FindNewsItemsRequest()
        apiClient.dispatch(request: request)
            .print("newItems Request")
        //TODO: extend publishers to add a generic way to log all this
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
            .sink(receiveCompletion: { completion in
                print("receiveCompletion: \(completion)")
            }, receiveValue: { newItems in
                print("newItems: \(newItems)")
            })
            .store(in: &cancellables)
    }
    
    func z() {
        let apiClient = APIClient(baseURL: "https://jsonplaceholder.typicode.com")
        
        let request = FindTodosRequest()
        apiClient.dispatch(request: request)
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
            .sink(receiveCompletion: { completion in
                print("receiveCompletion: \(completion)")
            }, receiveValue: { todo in
                print("Todo: \(todo)")
            })
//            .sink(receiveCompletion: { _ in },
//                  receiveValue: { value in
//                    print(value)
//                })
            .store(in: &cancellables)
    }
}
