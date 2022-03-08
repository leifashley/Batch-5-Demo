//
//  Batch_5_DemoTests.swift
//  Batch 5 DemoTests
//
//  Created by Leif Ashley on 3/7/22.
//

import XCTest
@testable import Batch_5_Demo

class Batch_5_DemoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNewsURL() throws {
        XCTAssertEqual(Constants.Network.apiNewsListCount, "https://api.spaceflightnewsapi.net/v3/articles/count")
        XCTAssertEqual(Constants.Network.apiNewsListItem(id: 1), "https://api.spaceflightnewsapi.net/v3/articles/1")
        /*
        XCTAssertEqual(Constants.Network.apiNewsListing(parameters: [
            "title_contains":"euro",
            "_start": "1",
            "_limit": "10"
        ]), "https://api.spaceflightnewsapi.net/v3/articles?title_contains=euro&_start=1&_limit=10")
         */
    }

    func testNewsCount() throws {
        let expectation = expectation(description: "apiNewsCount")
        let io = DispatchQueue(label: "apiNewsCount")
        let handle = NewsListCountService(session: .shared, io: io)
            .getListCount { count in
                XCTAssertGreaterThan(count, 0)
                print("test apiNewsCount =", count)
                expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
        handle?.cancel()
    }
    
    func testNewsItemLongMarch() throws {
        let expectation = expectation(description: "apiNewsItem")
        let id = 14173
        let handle = NewsListItemService().getItem(id: id, errorPlaceHolder: NewsItemModel()) { item in
            XCTAssertEqual(item.id, id)
            expectation.fulfill()
            print(item)
        }
        wait(for: [expectation], timeout: 5)
        handle?.cancel()
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
