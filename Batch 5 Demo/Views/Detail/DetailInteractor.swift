//
//  DetailInteractor.swift
//  Batch 5 Demo
//
//  Created by Eric on 3/8/22.
//

import Foundation

class DetailInteractor {
    var entity = Article()
    
    func getArticleWith(articleID: Int) -> Article {
        if articleID == 0 {
            return Article()
        } else {
            // when available, call /article/id here
            return Article()
        }
    }
}
