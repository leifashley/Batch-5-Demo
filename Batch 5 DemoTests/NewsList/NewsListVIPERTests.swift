//
//  NewsListVIPERTests.swift
//  Batch 5 DemoTests
//
//  Created by Sheharyar Irfan on 2022-03-11.
//

import XCTest
@testable import Batch_5_Demo

class NewsListVIPERTests: XCTestCase {

    var interactor: NewsListViewInteractor!
    var sut: UISearchListViewController!
    
    override func setUpWithError() throws {
        interactor = NewsListViewInteractor()
        interactor.setup(repository: NewsItemsRespository())
        let router = NewsListViewRouter()
        sut = router.makeListViewController(interactor: interactor) as? UISearchListViewController
    }

    override func tearDownWithError() throws {
        interactor = nil
        sut = nil
        
    }

    func testGetNewsLists() throws {
        // Arrange
        let expectation = expectation(description: "News lists")
        
        // Act
        interactor.getNewsItems(searchString: nil) { news in
            if news.count > 0 {
                expectation.fulfill()
            }
        }
        
        // Expect
        wait(for: [expectation], timeout: 5)
    }
    
    func testGetNewsLists_withSearchString() throws {
        // Arrange
        let expectation = expectation(description: "News lists")
        let testString = "new"
        
        // Act
        interactor.getNewsItems(searchString: testString) { news in
            if news.count > 0 {
                expectation.fulfill()
            }
        }
        
        // Expect
        wait(for: [expectation], timeout: 5)
    }


}
