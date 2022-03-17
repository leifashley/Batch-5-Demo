//
//  NewsListingWebServiceTests.swift
//  Batch 5 DemoTests
//
//  Created by Sheharyar Irfan on 2022-03-11.
//

import XCTest
@testable import Batch_5_Demo

class NewsListingWebServiceTests: XCTestCase {

    //var sut: NewsListingService!

    override func setUpWithError() throws {
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        let io = DispatchQueue(label: "News")
        //sut = NewsListingService(session: urlSession, io: io)
        
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
        let expectation = expectation(description: "apiNewsCount1")
        
        let jsonString = "[{\"id\":14203,\"title\":\"SpaceX to launch AST SpaceMobile’s first space-based cell towers\",\"url\":\"https://www.teslarati.com/spacex-ast-spacemobile-bluebird-launch-contract/\",\"imageUrl\":\"https://www.teslarati.com/wp-content/uploads/2022/03/BlueBird-satellite-AST-SpaceMobile-render-6-crop-c.jpg\",\"newsSite\":\"Teslarati\",\"summary\":\"AST Space Mobile says it has chosen SpaceX to launch its first operational BlueBird satellite after contracting the company to launch BlueWalker...\",\"publishedAt\":\"2022-03-11T12:14:22.000Z\",\"updatedAt\":\"2022-03-11T12:14:30.827Z\",\"featured\":false,\"launches\":[],\"events\":[]}]\""
        
        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)
        
//        sut.getList(keywords: nil, start: -1, limit: 1, entityType: NewsItem.self) { newsItems in
//            XCTAssertTrue(newsItems.count == 1, "News count of 1 expectation not met")
//            print("newsCount")
//            expectation.fulfill()
//        }
        wait(for: [expectation], timeout: 5)
//        let handle = NewsListService(session: .shared, io: io)
//            .getListCount { count in
//                XCTAssertGreaterThan(count, 0)
//                print("test apiNewsCount =", count)
//                expectation.fulfill()
//        }
        
    }
    
    func testNewsItemLongMarch() throws {
        let expectation = expectation(description: "apiNewsItem")
        let id = 14173
//        let handle = NewsListItemService().getItem(id: id, placeholder: NewsItem()) { item in
//            XCTAssertEqual(item.id, id)
//            expectation.fulfill()
//            print(item)
//        }
        wait(for: [expectation], timeout: 5)
       // handle?.cancel()
    }
    func testNewsListLongMarch() throws {
        let expectation = expectation(description: "apiNewsItem")
        let id = 14173
//        let handle = NewsListingService().getList(keywords: "long", entityType: NewsItem.self) { items in
//            XCTAssertFalse(items.isEmpty)
//            print(items)
//            let filtered = items.map { $0.id }
//            XCTAssertTrue(filtered.contains { $0 == id})
//            expectation.fulfill()
//        }
        wait(for: [expectation], timeout: 5)
     
    }

    var imageIcon: UIImage? = nil
    func testURLImage() throws {
        let expectation = expectation(description: "URLImage")
        let queue = DispatchQueue(label: "URLImage")
        let handle = URL(string: "https://www.swift.org/favicon.ico")?.assignWebImage(to: \.imageIcon, on: self)
        XCTAssertNotNil(handle)
        queue.asyncAfter(deadline: .now() + 2.0) {
            DispatchQueue.main.async {
                XCTAssertNotNil(self.imageIcon)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 5)
        handle?.cancel()
    }
}
