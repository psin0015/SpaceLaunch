//
//  AstronautListRequest.swift
//  SpaceLaunch
//
//  Created by Prashant Singh on 8/3/2023.
//

import Foundation

struct AstronautListRequest: DataRequest {
    var helper = Helper()
    
    var url: String {
        let baseURL: String = helper.astronautListBaseURL
        return baseURL
    }
    
    var headers: [String : String] {
        [:]
    }
    
    var method: HTTPMethod {
        .get
    }
    
    func decode(_ data: Data) throws -> [Astronaut] {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-mm-dd"
//        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        let response = try decoder.decode(AstronautResponse.self, from: data)
        return response.results
    }
}
