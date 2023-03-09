//
//  MockDataService.swift
//  SpaceLaunchTests
//
//  Created by Prashant Singh on 9/3/2023.
//

import Foundation
@testable import SpaceLaunch

final class MockNetworkService: NetworkService {    
    func request<Request: DataRequest>(_ request: Request, completion: @escaping (Result<Request.Response, Error>) -> Void) {
        
        var mockFileName = ""
        if request.url.contains("\(TestStringConstants.mockAstronautId)") {
            mockFileName = TestStringConstants.astronautDetailsMockFileName
        } else {
            mockFileName = TestStringConstants.astronautListMockFileName
        }
        
        if let data = AstronautDataGenerator.getAstronautData(fileName: mockFileName) {
            try? completion(.success(request.decode(data)))
        }
    }
}
