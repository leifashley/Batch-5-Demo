//
//  NewsListViewControllerTests.swift
//  Batch 5 DemoTests
//
//  Created by Sheharyar Irfan on 2022-03-11.
//

import XCTest
@testable import Batch_5_Demo

class NewsListViewControllerTests: XCTestCase {
    
    var storyboard: UIStoryboard!
    var sut: UISearchListViewController!

    override func setUpWithError() throws {
        
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "UISearchListViewController") as? UISearchListViewController
        sut.loadViewIfNeeded()
        
    }

    override func tearDownWithError() throws {
        storyboard = nil
        sut = nil
    }
    
    func testNewsListVC_initial_SearchListEmpty() {
        XCTAssertEqual(sut.searchBar.text, "")
    }
    
    func testNewsListVC_IBOutletsNonNil() throws {
        _ = try XCTUnwrap(sut.searchView, "The search view is not connected to IBOutlet")
        _ = try XCTUnwrap(sut.searchBgView, "The search Bg view is not connected to IBOutlet")
        _ = try XCTUnwrap(sut.searchBar, "The search bar is not connected to IBOutlet")
        _ = try XCTUnwrap(sut.tableView, "The table view is not connected to IBOutlet")
    }

    
    

}
