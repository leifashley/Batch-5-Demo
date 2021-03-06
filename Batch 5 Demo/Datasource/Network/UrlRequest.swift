//
//  Network.swift
//  Batch 5 Demo
//
//  Created by Leif Ashley on 3/11/22.
//

import Foundation
import Combine

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public protocol Request {
    associatedtype ReturnType: Codable
    
    var path: String { get }
    var method: HTTPMethod { get }
    var contentType: String { get }
    var body: [String: Any]? { get }
    var headers: [String: String]? { get }
    
    var queryItems: [URLQueryItem]? { get }
}

extension Request {
    // Defaults
    var method: HTTPMethod { return .get }
    var contentType: String { return "application/json"}
    var body: [String: Any]? { return nil }
    var headers: [String: String]? { return nil }
}

extension Request {
    private func requestBodyFrom(params: [String: Any]?) -> Data? {
        guard let params = params else { return nil }
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
            return nil
        }
        
        return httpBody
    }
    
    func asURLRequest(baseURL: String) -> URLRequest? {
        guard var urlComponents = URLComponents(string: baseURL) else { return nil }
        
        urlComponents.path = "\(urlComponents.path)\(path)"
        
        if let q = queryItems {
            urlComponents.queryItems = q
        }
        
        guard let finalURL = urlComponents.url else { return nil }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        request.httpBody = requestBodyFrom(params: body)
        request.allHTTPHeaderFields = headers
        
        return request
    }
}
