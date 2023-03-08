//
//  AstronautViewModel.swift
//  SpaceLaunch
//
//  Created by Prashant Singh on 8/3/2023.
//

import Foundation

protocol AstronautViewModel {
    var astronaut: Astronaut { set get }
}

final class AstronautDefaultViewModel: AstronautViewModel {
    
    var astronaut: Astronaut
    
    init(astronaut: Astronaut) {
        self.astronaut = astronaut
    }
}
