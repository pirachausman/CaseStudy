//
//  FetchPhotosPresenter.swift
//  CaseStudy
//
//  Created by Usman Piracha on 29/06/2021.
//

import Foundation

protocol FetchPhotosView: class {
    func reloadPhotos()
    func showError(title: String, message: String)
}

protocol FetchPhotosPresenter {
    var photos: [Photo] { get }
    
    func fetchPhotos()
}

class FetchPhotosPresenterImpl: FetchPhotosPresenter {
    var photos: [Photo] = []
    
    weak var view: FetchPhotosView?
    let fetchPhotosUsecase: FetchPhotosUsecase
    
    init(view: FetchPhotosView, usecase: FetchPhotosUsecase) {
        self.view = view
        self.fetchPhotosUsecase = usecase
    }
    
    func fetchPhotos() {
        fetchPhotosUsecase.fetchPhotos(){ [weak self] result in
            switch result {
            case .success(let photos):
                self?.photos = photos
                self?.view?.reloadPhotos()
            case .failure(let error):
                self?.view?.showError(title: "Alert", message: error.localizedDescription)
            }
        }
    }

}

