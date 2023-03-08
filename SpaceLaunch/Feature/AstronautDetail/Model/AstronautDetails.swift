//
//  AstronautDetails.swift
//  SpaceLaunch
//
//  Created by Prashant Singh on 8/3/2023.
//

import Foundation

struct AstronautDetails: Decodable {
    let id: Int
    let name: String
    let nationality: String
    let dateOfBirth: String
    let profileImage: String
    let bio: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case nationality
        case dateOfBirth = "date_of_birth"
        case profileImage = "profile_image"
        case bio
    }
}
