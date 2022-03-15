//
//  NewsListDetailViewTests.swift
//  Batch 5 DemoTests
//
//  Created by Sheharyar Irfan on 2022-03-11.
//

import XCTest
@testable import Batch_5_Demo

class NewsListDetailViewTests: XCTestCase {
    var newsList: NewsListViewRouter!

    override func setUpWithError() throws {
        newsList = NewsListViewRouter()
    }

    override func tearDownWithError() throws {
        newsList = nil
    }

    func testNewsDetailViewPopulated_withCorrectArticle() {
        // Arrange
        let testArticleID = 14203
        let model = NewsItem(id: testArticleID, title: "TestTitle", url: "testURL", imageUrl: "TestImgURL", newsSite: "", summary: "", publishedAt: Date(), updatedAt: Date(), featured: false)
        
        // Act
        let detailView = newsList.makeDetailViewController(model: model) as? NewsDetailView
        
        // Assert
        XCTAssertEqual(detailView?.newsItem.id, testArticleID)
        
    }
    
    func testNewsDetailViewPopulated_withWrongArticle() {
        // Arrange
        let testBadArticle = 1
        
        // Act
        let detailView = newsList.makeDetailViewController(model: testBadArticle) as? NewsDetailView
        
        // Assert
        XCTAssertEqual(detailView, nil)
        
    }

}
