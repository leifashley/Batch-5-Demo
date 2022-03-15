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
    let title = "NetworkDispatcher"
    let urlSession: URLSession
    
    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func dispatch<ReturnType: Codable>(request: URLRequest) -> AnyPublisher<ReturnType, NetworkRequestError> {
        let ftitle = "\(title).dispatch"
        log.debug(title: ftitle, "URL Request: \(request)")
        log.debug(title: ftitle, "Return type: \(ReturnType.self)")
       
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(Date.iso8601Adaptive)
        
        return urlSession.dataTaskPublisher(for: request)
//            .print("DEBUG") //debug tracking
            .tryMap({ data, response in
                if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                    log.error(title: ftitle, "Response Error code: \(response.statusCode)", error: NetworkRequestError.badRequest)
                    throw httpError(response.statusCode)
                }
                
                return data
            })
            .decode(type: ReturnType.self, decoder: decoder)
            .mapError { error in
                handleError(error)
            }
            .eraseToAnyPublisher()
    }
}

extension NetworkDispatcher {
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
        log.error(title: title, "dispatch failure", error: error)
        
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




