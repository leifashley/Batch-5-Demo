//
//  DetailEntity.swift
//  Batch 5 Demo
//
//  Created by Eric on 3/8/22.
//

import Foundation

struct Article: Decodable {
    var id = 0
    var featured = false
    var title = "Title"
    var url = "https://news.google.com"
    var imageUrl = ""
    var newsSite = ""
    var summary = ""
    var publishedAt = ""
}
