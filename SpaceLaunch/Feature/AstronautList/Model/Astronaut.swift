//
//  Astronaut.swift
//  SpaceLaunch
//
//  Created by Prashant Singh on 8/3/2023.
//

import Foundation


public struct AstronautResponse: Codable {
    public let results: [Astronaut]
}

public struct Astronaut: Codable {
    let id: Int
    let name: String
    let nationality: String
    let profileImageThumbnail: String
}
