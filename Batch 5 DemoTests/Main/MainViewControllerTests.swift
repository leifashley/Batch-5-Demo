//
//  MainViewControllerTests.swift
//  Batch 5 DemoTests
//
//  Created by Sheharyar Irfan on 2022-03-11.
//

import XCTest
@testable import Batch_5_Demo

class MainViewControllerTests: XCTestCase {
    
    var storyboard: UIStoryboard!
    var sut: MainViewController!
    var navigationController: UINavigationController!
    

    override func setUpWithError() throws {
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController
        sut.loadViewIfNeeded()
        navigationController = UINavigationController(rootViewController: sut)
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //TODO: button removed, entire view is tappable. Needs to be replaced with UITapGestureRecognizer test
//    func testMainViewController_HasEnterButtonAndAction() throws {
//        // Arrange
//        let tapGesture: UITapGestureRecognizer = try XCTUnwrap(sut.tapGesture, "UITapGestureRecognizer not available")
////        let newsButton: UIButton = try XCTUnwrap(sut.NewsButton, "News button does not have an outlet")
//
//        // Act
//        let newsButtonActions = try XCTUnwrap(newsButton.actions(forTarget: sut, forControlEvent: .touchUpInside), "News button does not have any action assigned to it")
//
//        // Assert
//        XCTAssertEqual(newsButtonActions.count, 1)
//        XCTAssertEqual(newsButtonActions.first, "onClick:", "No action with a name onClick assigned to newsButton")
//    }
    
    func testMainViewController_ClickEnterButtonAndTransition() throws {
        
        // Arrange
        let predicate = NSPredicate {input,_ in
            return (input as? UINavigationController)?.topViewController is UISearchListViewController
        }
        
        // Act
        sut.pushViewController()
        
        // Expect
        expectation(for: predicate, evaluatedWith: sut.navigationController)
        waitForExpectations(timeout: 5)
        
    }

    

}
