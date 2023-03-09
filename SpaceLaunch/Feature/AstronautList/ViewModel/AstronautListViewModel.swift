//
//  AstronautListViewModel.swift
//  SpaceLaunch
//
//  Created by Prashant Singh on 8/3/2023.
//

import Foundation

protocol AstronautListViewModel: AnyObject {
    var astronauts: [Astronaut] { set get }
    var onFetchAstronautsSucceed: (() -> Void)? { set get }
    var onAstronautListSort: (() -> Void)? { set get }
    var onFetchAstronautsFailure: ((Error) -> Void)? { set get }
    func fetchAstronauts()
    func sortAstronautNames()
}

final class AstronautListDefaultViewModel: AstronautListViewModel {
    
    private let networkService: NetworkService
    private var astronautListSorted = false
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    var astronauts: [Astronaut] = []
    var onFetchAstronautsSucceed: (() -> Void)?
    var onAstronautListSort: (() -> Void)?
    var onFetchAstronautsFailure: ((Error) -> Void)?
    
    func fetchAstronauts() {
        let request = AstronautListRequest()
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let astronauts):
                self?.astronauts = astronauts
                self?.onFetchAstronautsSucceed?()
            case .failure(let error):
                self?.onFetchAstronautsFailure?(error)
            }
        }
    }
    
    func sortAstronautNames() {
        if (astronautListSorted) {
            self.astronauts.reverse()
        } else {
            self.astronauts.sort { $0.name > $1.name }
            astronautListSorted = true
        }
        self.onAstronautListSort?()
    }
}
