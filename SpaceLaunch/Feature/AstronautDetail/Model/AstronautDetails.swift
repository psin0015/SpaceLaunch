//
//  AstronautDetails.swift
//  SpaceLaunch
//
//  Created by Prashant Singh on 8/3/2023.
//

import Foundation

struct AstronautDetails: Codable {
    let id: Int
    let name: String
    let nationality: String
    let dateOfBirth: String
    let profileImage: String
    let bio: String
}
