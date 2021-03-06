//
//  NewsItemModel.swift
//  Batch 5 Demo
//
//  Created by Rockford Wei on 2022-03-08.
//

import Foundation

struct NewsItem: Codable {
    let id: Int
    let title: String
    let url: String
    let imageUrl: String
    let newsSite: String
    let summary: String
    let publishedAt: Date
    let updatedAt: Date
    let featured: Bool
    
    init(id i: Int = -1, title t: String = "", url u: String = "",
         imageUrl img: String = "", newsSite n: String = "", summary s: String = "",
         publishedAt pat: Date = Date(), updatedAt uat: Date = Date(), featured f: Bool = false) {
        id = i; title = t; url = u
        imageUrl = img; newsSite = n; summary = s
        publishedAt = pat; updatedAt = uat; featured = f
    }
}
