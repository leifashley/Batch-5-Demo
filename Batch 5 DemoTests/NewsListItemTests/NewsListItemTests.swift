//
//  NewsListItemTests.swift
//  Batch 5 DemoTests
//
//  Created by Sheharyar Irfan on 2022-03-14.
//

import XCTest
@testable import Batch_5_Demo

class NewsListItemTests: XCTestCase {
    
    var storyboard: UIStoryboard!
    var newsListview: UISearchListViewController!
    var sut: NewsListItemView!
    

    override func setUpWithError() throws {
        
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        newsListview = storyboard.instantiateViewController(withIdentifier: "UISearchListViewController") as? UISearchListViewController
        newsListview.loadViewIfNeeded()
         
        sut = newsListview.tableView.dequeueReusableCell(withIdentifier: "NewsListItemView") as? NewsListItemView

    }

    override func tearDownWithError() throws {
        sut = nil
        newsListview = nil
        storyboard = nil
    }
    
    func testListItemView_IBOutletsNonNil() throws {
        _ = try XCTUnwrap(sut.cardView)
        _ = try XCTUnwrap(sut.splineView)
        _ = try XCTUnwrap(sut.iconView)
        _ = try XCTUnwrap(sut.titleLbl)
        _ = try XCTUnwrap(sut.timeLbl)
        _ = try XCTUnwrap(sut.newsSiteLbl)
    }
    
    
    
    
    
    

    

}
