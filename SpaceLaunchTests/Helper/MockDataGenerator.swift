//
//  MockDataGenerator.swift
//  SpaceLaunchTests
//
//  Created by Prashant Singh on 9/3/2023.
//

import Foundation

final class AstronautDataGenerator {    
    static func getAstronautData(fileName: String) -> Data? {
        guard
            let jsonFileName = Bundle.main.url(forResource: fileName, withExtension: "json"),
            let astronautData = try? Data(contentsOf: jsonFileName)
        else { return nil}
        return astronautData
    }
}
