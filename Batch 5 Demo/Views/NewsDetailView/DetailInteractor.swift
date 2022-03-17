//
//  DetailInteractor.swift
//  Batch 5 Demo
//
//  Created by Eric on 3/8/22.
//

import Foundation

class DetailInteractor {
    var entity = Article()
    
    func getNewsItem(articleID: Int) -> NewsItem {
        NewsItem(id: articleID)
    }
}
