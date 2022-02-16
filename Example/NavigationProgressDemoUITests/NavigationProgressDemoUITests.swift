//
//  NavigationProgressDemoUITests.swift
//  NavigationProgressDemoUITests
//
//  Created by Chris Ng on 12/2/2022.
//

import XCTest

class NavigationProgressDemoUITests: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testExample() throws {
    // UI tests must launch the application that they test.
    let app = XCUIApplication()
    app.launch()
    
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
  }
  
  func testNavigationProgressOneTime() throws {
    // UI tests must launch the application that they test.
    let app = XCUIApplication()
    app.launch()
    
    tapPushOrPresentVC(app)
    tapTableViewRow(app)
    XCTAssert(app.progressIndicators["np_ProgressBarView"].waitForExistence(timeout: 1))
    
    tapTableViewRow(app)
    tapTableViewRow(app)
    XCTAssert(!app.progressIndicators["np_ProgressBarView"].waitForExistence(timeout: 1))
    
    navigateBack(app)
    navigateBack(app)
    XCTAssert(!app.progressIndicators["np_ProgressBarView"].waitForExistence(timeout: 1))
    
    navigateBack(app)
    navigateBack(app)
    XCTAssert(!app.progressIndicators["np_ProgressBarView"].waitForExistence(timeout: 1))
    
    tapPushOrPresentVC(app)
    tapTableViewRow(app)
    XCTAssert(app.progressIndicators["np_ProgressBarView"].waitForExistence(timeout: 1))
    
  }
  
  func testNavigationProgressAlways() throws {
    // UI tests must launch the application that they test.
    let app = XCUIApplication()
    app.launch()
    
    app.switches["np_OneTimeSwitch"].tap()
    tapPushOrPresentVC(app)
    tapTableViewRow(app)
    XCTAssert(app.progressIndicators["np_ProgressBarView"].waitForExistence(timeout: 1))
    
    tapTableViewRow(app)
    tapTableViewRow(app)
    XCTAssert(!app.progressIndicators["np_ProgressBarView"].waitForExistence(timeout: 1))
    
    navigateBack(app)
    navigateBack(app)
    XCTAssert(app.progressIndicators["np_ProgressBarView"].waitForExistence(timeout: 1))
    
    navigateBack(app)
    navigateBack(app)
    XCTAssert(!app.progressIndicators["np_ProgressBarView"].waitForExistence(timeout: 1))
    
    tapPushOrPresentVC(app)
    tapTableViewRow(app)
    XCTAssert(app.progressIndicators["np_ProgressBarView"].waitForExistence(timeout: 1))
  }
  
  
  func testLaunchPerformance() throws {
    if #available(macOS 10.15, iOS 10.0, tvOS 13.0, watchOS 7.0, *) {
      // This measures how long it takes to launch your application.
      measure(metrics: [XCTApplicationLaunchMetric()]) {
        XCUIApplication().launch()
      }
    }
  }
  
  // private helper functions
  
  private func tapPushOrPresentVC(_ app: XCUIApplication) {
    app.buttons["Push or Present VC"].tap()
  }
  
  private func navigateBack(_ app: XCUIApplication) {
    app.navigationBars.buttons.element(boundBy: 0).tap()
  }
  
  private func tapTableViewRow(_ app: XCUIApplication) {
    app.tables.firstMatch.cells.firstMatch.tap()
  }
}
