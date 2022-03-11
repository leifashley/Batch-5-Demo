//
//  NewsListItemViewInteractor.swift
//  Batch 5 Demo
//
//  Created by qiaoliwen on 2022/3/11.
//

import Foundation

protocol NewsListItemViewInputInteractorProtocal {
    
}

protocol NewsListItemViewOutputInteractorProtocal: AnyObject {
    func didGetNewItem(newsItem: NewsItem)
}

class NewsListItemViewInteractor : NewsListItemViewInputInteractorProtocal {
    
    weak var presenter : NewsListItemViewOutputInteractorProtocal?
    
    func getNewsItem(newItem: NewsItem?){
        if let newItem = newItem{
            presenter?.didGetNewItem(newsItem: newItem)
        }
    }
}

