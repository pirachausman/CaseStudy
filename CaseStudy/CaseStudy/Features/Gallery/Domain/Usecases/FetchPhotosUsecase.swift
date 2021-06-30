//
//  FetchPhotosUsecase.swift
//  CaseStudy
//
//  Created by Usman Piracha on 29/06/2021.
//

import Foundation

typealias FetchPhotosCallback = (_ albums: Result<[Photo], Error>) -> Void

protocol FetchPhotosUsecase {
    func fetchPhotos(callback: @escaping FetchPhotosCallback)
}

class FetchPhotosUsecaseImpl: FetchPhotosUsecase {
    
    let gateway: FetchPhotosGateway
    init(gateway: FetchPhotosGateway) {
        self.gateway = gateway
    }
    
    func fetchPhotos(callback: @escaping FetchPhotosCallback) {
        gateway.fetchPhotos() { result in
            DispatchQueue.main.async {
                callback(result)
            }
        }
    }

}
