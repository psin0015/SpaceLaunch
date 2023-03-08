//
//  ErrorResponse.swift
//  SpaceLaunch
//
//  Created by Prashant Singh on 8/3/2023.
//

import Foundation

enum ErrorResponse: String {
    case invalidEndpoint
    case invalidResponse
    
    public var description: String {
        switch self {
        case .invalidEndpoint: return "API URL incorrect"
        case .invalidResponse: return "API Response invalid"
        }
    }
}
