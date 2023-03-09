//
//  ImageDownloadRequest.swift
//  SpaceLaunch
//
//  Created by Prashant Singh on 8/3/2023.
//

import UIKit

struct ImageDownloadRequest: DataRequest {
    
    let url: String
    
    var method: HTTPMethod {
        .get
    }
    
    func decode(_ data: Data) throws -> UIImage {
        guard let image = UIImage(data: data) else { throw NSError(domain: ErrorResponse.invalidResponse.rawValue, code: 13) }
        return image
    }
}
