//
//  HomeViewModelTest.swift
//  ApollonAssignmentTests
//
//  Created by Poonam on 17/08/21.
//

import XCTest
@testable import ApollonAssignment


class HomeViewModelTest: XCTestCase {
    var results : [ResponseResult] = [];
    var failedData : [ResponseResult] = [];
    var vModel : HomeViewModel?
    var successData : ResponseResult?;

    
    // Test HomeViewModel methods
    func testShortenProvidedURL() {
        let url = "www.google.com"
        vModel?.shortenProvidedURL(url : url);
        XCTAssertTrue(true);
    }
    
    
    // save data of viewmodel
    func testSaveData(results : [ResponseResult]) {
        vModel?.saveData(dataToBeSaved: results);
        XCTAssert(true, "Data saved successfully!")
        vModel?.saveData(dataToBeSaved: failedData);
        XCTAssert(false, "Failed to save data!")

    }
    // test load data func of view model
    func testLoadData() {
        guard (vModel?.loadData()) != nil else {
            XCTAssertFalse(true);
            return
        }
        XCTAssertTrue(true);
    }
    
    // test if deleting particular record works
    func testDeleteData() {
        vModel?.removeLinkAtIndex(indexToBeDeleted: 0);
        XCTAssertTrue(true);
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        vModel = HomeViewModel();
        // create test data to be saved

        successData?.code = "";
        successData?.short_link = "";
        successData?.full_short_link = "";
        successData?.full_short_link2 = "";
        successData?.full_short_link3 = "";
        successData?.short_link2 = "";
        successData?.short_link3 = "";
        successData?.share_link = "";
        successData?.full_share_link = "";
        successData?.original_link = "";
        
       // let successData = try? JSONEncoder().encode(successData!)
        guard let item = successData else {
            return
        }
        results.append(item)
        
        
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
