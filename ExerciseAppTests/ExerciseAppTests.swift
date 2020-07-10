//
//  ExerciseAppTests.swift
//  ExerciseAppTests
//
//  Created by Pranav V K on 08/07/20.
//  Copyright © 2020 Pranav V K. All rights reserved.
//

import XCTest
@testable import ExerciseApp

class ExerciseAppTests: XCTestCase {
    private let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first ?? UIWindow(frame: UIScreen.main.bounds)
    let viewControllerForTest = MainViewController()
    
    override func setUpWithError() throws {
        let dict = [ "title": "About Kerala",
                     "rows":[[
                        "title":"God’s own country",
                        "description":"Kerala tourism is a global brand and regarded as one of the destinations with highest recall.",
                        "imageHref":"https://en.wikipedia.org/wiki/Kerala#/media/File:Athirappilly_Waterfalls_1.jpg"],
                             [
                                "title":"Music",
                                "description":"The development of classical music in Kerala is attributed to the contributions it received from the traditional performance arts associated with the temple culture of Kerala.",
                                "imageHref":"https://en.wikipedia.org/wiki/Kerala#/media/File:Smitha_Rajan.JPG"],
                             [
                                "title":"Food",
                                "description":nil,
                                "imageHref":"https://en.wikipedia.org/wiki/Kerala#/media/File:Sadhya_DSW.jpg"]]
            ] as [String : AnyObject]
        let data = try? JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted)
        let modelData = try JSONDecoder().decode(CountryModel.self, from: data!)
        viewControllerForTest.viewModel.countryModel = modelData
        window.isHidden = false
        window.rootViewController = viewControllerForTest
        viewControllerForTest.viewWillAppear(false)
        viewControllerForTest.viewDidAppear(false)
        viewControllerForTest.countryTableView.reloadData()
    }
    
    func testCountryModel() {
        XCTAssertEqual(viewControllerForTest.viewModel.countryModel?.title, "About Kerala")
        XCTAssertEqual(viewControllerForTest.viewModel.countryModel?.details.count, 3)
        XCTAssertEqual(viewControllerForTest.viewModel.countryModel?.details[0].title ?? "", "God’s own country")
        XCTAssertNil(viewControllerForTest.viewModel.countryModel?.details[2].description)
        XCTAssertEqual(viewControllerForTest.viewModel.countryModel?.details[2].imageUrl ?? "", "https://en.wikipedia.org/wiki/Kerala#/media/File:Sadhya_DSW.jpg")
    }
    
    func testCountryViewModel() {
        XCTAssertEqual(viewControllerForTest.viewModel.numberOfRows, 3)
    }
    
    func testCountryTableView() {
        XCTAssertNotNil(viewControllerForTest.countryTableView)
        XCTAssertNotNil(viewControllerForTest.countryTableView.dataSource)
        XCTAssertEqual(viewControllerForTest.countryTableView.numberOfSections, 1)
        XCTAssertEqual(viewControllerForTest.countryTableView.numberOfRows(inSection: 0), 3)
    }
    
    func testWebServiceCall() {
        let expectation = XCTestExpectation(description: "Verify webservice call")
        viewControllerForTest.viewModel.loadData { (status) in
            XCTAssertTrue(status == true || status == false)
            if status == true {
                XCTAssertNotNil(self.viewControllerForTest.viewModel.countryModel)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    override func tearDown() {
        super.tearDown()
        let rootViewController = window.rootViewController
        rootViewController?.viewWillDisappear(false)
        rootViewController?.viewDidDisappear(false)
        window.rootViewController = nil
        window.isHidden = true
    }
}
