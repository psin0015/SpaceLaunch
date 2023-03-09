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
        } else if request.url.contains("\(TestStringConstants.mockUnknownAstronautId)")   {
            mockFileName = TestStringConstants.unknownFileName
        } else {
            mockFileName = TestStringConstants.astronautListMockFileName
        }
        
        if let data = AstronautDataGenerator.getAstronautData(fileName: mockFileName) {
            try? completion(.success(request.decode(data)))
        } else {
            completion(.failure(NSError(
                domain: ErrorResponse.invalidEndpoint.rawValue,
                code: 404,
                userInfo: nil
            )))
        }
    }
}
