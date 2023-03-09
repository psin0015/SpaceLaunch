//
//  AstronautDetailsViewModel.swift
//  SpaceLaunch
//
//  Created by Prashant Singh on 8/3/2023.
//

import Foundation

protocol AstronautDetailsViewModel: AnyObject {
    var astronautDetail: AstronautDetails? { set get }
    var onFetchAstronautDetailsSucceed: (() -> Void)? { set get }
    var onFetchAstronautDetailsFailure: ((Error) -> Void)? { set get }
    func fetchAstronautDetail(astronautId: Int)
}

final class AstronautDetailsDefaultViewModel: AstronautDetailsViewModel {
    
    private let networkService: NetworkService
    var astronautDetail: AstronautDetails?
    var onFetchAstronautDetailsSucceed: (() -> Void)?
    var onFetchAstronautDetailsFailure: ((Error) -> Void)?
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchAstronautDetail(astronautId: Int) {
        let request = AstronautDetailsRequest(astronautId: astronautId)
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let astronautDetail):
                self?.astronautDetail = astronautDetail
                self?.onFetchAstronautDetailsSucceed?()
            case .failure(let error):
                self?.onFetchAstronautDetailsFailure?(error)
            }
        }
    }
}
