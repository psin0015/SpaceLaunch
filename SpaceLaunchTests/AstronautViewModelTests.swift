//
//  AstronautViewModelTests.swift
//  SpaceLaunchTests
//
//  Created by Prashant Singh on 9/3/2023.
//

import XCTest
@testable import SpaceLaunch

final class AstronautViewModelTests: XCTestCase {            
    
    func testAstronautListViewModel() {
        let astronautListViewModel = AstronautListDefaultViewModel(networkService: MockNetworkService())
        astronautListViewModel.fetchAstronauts()
        XCTAssertGreaterThan(astronautListViewModel.astronauts.count, TestStringConstants.nilCount)
    }
    
    func testAstronautDetailViewModel() {
        let astronautListViewModel = AstronautDetailsDefaultViewModel(networkService: MockNetworkService())
        astronautListViewModel.fetchAstronautDetail(astronautId: TestStringConstants.mockAstronautId)
        XCTAssertNotNil(astronautListViewModel.astronautDetail)
    }
    
    func testAstronautDetailViewModelFailure() {
        let astronautListViewModel = AstronautDetailsDefaultViewModel(networkService: MockNetworkService())
        astronautListViewModel.fetchAstronautDetail(astronautId: TestStringConstants.mockUnknownAstronautId)
        XCTAssertNil(astronautListViewModel.astronautDetail)
    }
    
    func testSortAstronautNames() {
        let astronautListViewModel = AstronautListDefaultViewModel(networkService: MockNetworkService())
        astronautListViewModel.fetchAstronauts()
        astronautListViewModel.sortAstronautNames()
        XCTAssertEqual(astronautListViewModel.astronauts.map(\.name), TestStringConstants.decendingAstronautNameList)
        astronautListViewModel.sortAstronautNames()
        XCTAssertEqual(astronautListViewModel.astronauts.map(\.name), TestStringConstants.ascendingAstronautNameList)
    }
}
