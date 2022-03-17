//
//  Batch_5_DemoTests.swift
//  Batch 5 DemoTests
//
//  Created by Leif Ashley on 3/7/22.
//

import XCTest
@testable import Batch_5_Demo

class Batch_5_DemoTests: XCTestCase {
    
    //var sut: NewsListingService!

    override func setUpWithError() throws {
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        let io = DispatchQueue(label: "News")
       // sut = NewsListingService(session: urlSession, io: io)
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
