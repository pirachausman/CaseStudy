//
//  FetchPhotosConfig.swift
//  CaseStudy
//
//  Created by Usman Piracha on 29/06/2021.
//

import Foundation

protocol FetchPhotosConfigurator {
    func configure(fetchPhotosVC: FetchPhotosViewController)
}

class FetchPhotosConfig: FetchPhotosConfigurator {
    
    func configure(fetchPhotosVC: FetchPhotosViewController) {
        
        let usecase = FetchPhotosUsecaseImpl(gateway: FetchPhotosAPIGateway(service: NetworkService()))
        let presenter = FetchPhotosPresenterImpl(view: fetchPhotosVC, usecase: usecase)
        fetchPhotosVC.presenter = presenter
    }
}
