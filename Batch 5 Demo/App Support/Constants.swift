//
//  Constants.swift
//  Batch 5 Demo
//
//  Created by Leif Ashley on 3/4/22.
//

import Foundation

/// Application constants, self containted in the Constants struct to help make them easier ot find with dot references
struct Constants {
    struct Network {
        static let hostName = "https://api.spaceflightnewsapi.net"
        static let apiVersion = "v3"
        static let apiNews = "articles"
        
        private static var apiNewsRoot: String {
            return "\(hostName)/\(apiVersion)/\(apiNews)"
        }
        
        static var apiNewsListCount: String {
            return "\(apiNewsRoot)/count"
        }
        
        private static func makeQueryString(parameters: [String: String] = [:]) -> String {
            return parameters.reduce("") { previous, keyValue in
                let key = keyValue.key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? keyValue.key
                let value = keyValue.value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? keyValue.value
                let p = previous.isEmpty ? "?" : previous + "&"
                return "\(p)\(key)=\(value)"
            }
        }
        
        static func apiNewsListing(parameters: [String: String] = [:]) -> String {
            return apiNewsRoot + makeQueryString(parameters: parameters)
        }
        
        static func apiNewsListItem(id: Int) -> String {
            return "\(apiNewsRoot)/\(id)"
        }
        
        private static let apiBlogs = "blogs"
        private static var apiBlogsRoot: String {
            return "\(hostName)/\(apiVersion)/\(apiBlogs)"
        }
        
        static var apiBlogsListCount: String {
            return "\(apiBlogsRoot)/count"
        }
        
        static func apiBlogsListing(parameters: [String: String] = [:]) -> String {
            return apiBlogsRoot + makeQueryString(parameters: parameters)
        }
    }
}
