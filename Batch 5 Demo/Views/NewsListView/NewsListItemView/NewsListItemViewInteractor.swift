//
//  NewsListItemViewInteractor.swift
//  Batch 5 Demo
//
//  Created by qiaoliwen on 2022/3/11.
//

import Foundation

class NewsListItemViewInteractor {
    
    private var newsItem: NewsItem? = nil
    
    func assign(newsItem: NewsItem) {
        self.newsItem = newsItem
    }
    
    func getNewsItemModel() -> NewsItem{
        return newsItem ?? NewsItem()
    }
}

