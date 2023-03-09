//
//  Helpers.swift
//  SpaceLaunch
//
//  Created by Prashant Singh on 8/3/2023.
//

import Foundation

final class Helper {
    lazy var astronautListBaseURL: String = {
        guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "astronautListBaseURL") as? String else {
            fatalError("Astronaut List Base URL must not be empty in plist")
        }
        return apiBaseURL
    }()
}
