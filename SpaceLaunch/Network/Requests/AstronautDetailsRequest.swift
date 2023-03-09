//
//  AstronautDetailsRequest.swift
//  SpaceLaunch
//
//  Created by Prashant Singh on 9/3/2023.
//

import Foundation

struct AstronautDetailsRequest: DataRequest {
    var helper = Helper()
    var astronautId: Int
    var url: String {
        let baseURL: String = helper.astronautListBaseURL
        let path: String = "\(astronautId)"
        return baseURL + path
    }
    
    var headers: [String : String] {
        [:]
    }
    
    var method: HTTPMethod {
        .get
    }
    
    init(astronautId: Int) {
        self.astronautId = astronautId
    }
    
    func decode(_ data: Data) throws -> AstronautDetails {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let response = try decoder.decode(AstronautDetails.self, from: data)
        return response
    }
}
