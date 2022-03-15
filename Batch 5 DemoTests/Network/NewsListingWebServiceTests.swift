//
//  NewsListingWebServiceTests.swift
//  Batch 5 DemoTests
//
//  Created by Sheharyar Irfan on 2022-03-11.
//

import XCTest
import Combine
@testable import Batch_5_Demo

class NewsListingWebServiceTests: XCTestCase {

    var sut: NewsItemsRespository!
    var cancellable: AnyCancellable?

    override func setUpWithError() throws {
        sut = NewsItemsRespository()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testNewsURL() throws {
        XCTAssertEqual(Constants.Network.apiNewsListCount, "https://api.spaceflightnewsapi.net/v3/articles/count")
        XCTAssertEqual(Constants.Network.apiNewsListItem(id: 1), "https://api.spaceflightnewsapi.net/v3/articles/1")
    }

}
