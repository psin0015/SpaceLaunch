//
//  AstronautMockTests.swift
//  SpaceLaunchTests
//
//  Created by Prashant Singh on 9/3/2023.
//

import XCTest
@testable import SpaceLaunch

final class AstronautMockTests: XCTestCase {
        
    func testAstronautListDecode() {
        let astronautData = AstronautDataGenerator.getAstronautData(fileName: TestStringConstants.astronautListMockFileName)
        XCTAssertNotNil(astronautData)
        if let astronautData = astronautData {
            let astronautListRequest = AstronautListRequest()
            let astronautList = try? astronautListRequest.decode(astronautData)
            XCTAssertNotNil(astronautList)
            XCTAssertEqual(astronautList?.count, 10)
        }
    }
    
    func testAstronautListDetails() {
        let astronautData = AstronautDataGenerator.getAstronautData(fileName: TestStringConstants.astronautDetailsMockFileName)
        XCTAssertNotNil(astronautData)
        if let astronautData = astronautData {
            let astronautDetailsRequest = AstronautDetailsRequest(astronautId: TestStringConstants.mockAstronautId)
            let astronautDetail = try? astronautDetailsRequest.decode(astronautData)
            XCTAssertNotNil(astronautDetail)
            XCTAssertEqual(astronautDetail?.id, TestStringConstants.mockAstronautId)
            XCTAssertEqual(astronautDetail?.name, TestStringConstants.mockAstronautName)
            XCTAssertEqual(astronautDetail?.nationality, TestStringConstants.mockAstronautNationality)
            XCTAssertEqual(astronautDetail?.dateOfBirth, TestStringConstants.mockAstronautDateofBirth)
        }
    }
}
