//
//  ExtensionsTest.swift
//  Batch 5 DemoTests
//
//  Created by Rockford Wei on 2022-03-14.
//

import XCTest
@testable import Batch_5_Demo

class Extensions_Tests: XCTestCase {
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLocalizedString() throws {
        let helloWorld = "Hello, World!"
        XCTAssertEqual(helloWorld, helloWorld.localized())
    }
    func testColorAsHexInt() throws {
        let black = UIColor(webColorCode: 0)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        black.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        XCTAssertEqual(red, 0)
        XCTAssertEqual(green, 0)
        XCTAssertEqual(blue, 0)
        XCTAssertEqual(alpha, 1)
    }
    func testColorAsWebCode() throws {
        let black = UIColor(webColor: "#FFFFFF")
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        black.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        XCTAssertEqual(red, 1)
        XCTAssertEqual(green, 1)
        XCTAssertEqual(blue, 1)
        XCTAssertEqual(alpha, 1)
    }
    func testISO8601Adaptive() throws {
        let data = "{\"timestamp\": \"2017-06-14T13:48:59.000Z\"}".data(using: .utf8) ?? Data()
        struct DummyTime: Codable {
            let timestamp: Date
        }
        let json = JSONDecoder()
        json.dateDecodingStrategy = .custom(Date.iso8601Adaptive(_:))
        let dummy = try json.decode(DummyTime.self, from: data)
        let d = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: dummy.timestamp)
        XCTAssertEqual(d.year, 2017)
        XCTAssertEqual(d.month, 6)
        XCTAssertEqual(d.day, 14)
        //XCTAssertEqual(d.hour, 9) // - just leave the time zone
        XCTAssertEqual(d.minute, 48)
        XCTAssertEqual(d.second, 59)
    }
    func testDateFormat() throws {
        let epoch = Date(timeIntervalSince1970: 0)
        XCTAssertEqual(epoch.getFormattedDate(format: "dd/MM/yyyy HH:mm"), "31/12/1969 19:00")
    }
    func testAgo() throws {
        XCTAssertEqual(Date().ago(), "Just now")
        XCTAssertEqual(Date(timeIntervalSinceNow: -100).ago(), "A minute ago")
        XCTAssertEqual(Date(timeIntervalSinceNow: -1800).ago(), "30 minutes ago")
        XCTAssertEqual(Date(timeIntervalSinceNow: -5000).ago(), "An hour ago")
        XCTAssertEqual(Date(timeIntervalSinceNow: -36000).ago(), "10 hours ago")
        XCTAssertEqual(Date(timeIntervalSinceNow: -86500).ago(), "Yesterday")
        XCTAssertEqual(Date(timeIntervalSinceNow: -86400 * 3).ago(), "3 days ago")
    }
    
    /*
     // not sure how to test the keypath assignment properly.
    var image: UIImage! = nil
    func testLoadImageFromURL() throws {
        let expectation = expectation(description: "download image")
        let q = DispatchQueue(label: "checker")
        q.asyncAfter(deadline: .now() + 2) {
            XCTAssertNotNil(self.image)
            expectation.fulfill()
        }
        let handler = "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9d/Swift_logo.svg/191px-Swift_logo.svg.png?20210606004230".assignWebImage(to: \.image, on: self)
        XCTAssertNotNil(handler)
        wait(for: [expectation], timeout: 5)
        handler?.cancel()
    }
     */
}
