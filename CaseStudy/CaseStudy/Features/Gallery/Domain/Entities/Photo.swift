//
//  Photo.swift
//  CaseStudy
//
//  Created by Usman Piracha on 29/06/2021.
//

import Foundation

protocol GalleryImageViewDetails{
    var webformatURL:String {get}
}
struct Photo:GalleryImageViewDetails {

    let previewURL, type,webformatURL : String
}

struct PhotoDTO: Decodable {

    var previewURL, type, webformatURL:String?
    func map() -> Photo? {
        guard let previewURL = previewURL, let type = type, let webformatURL = webformatURL else {
            return nil
        }
        return Photo(previewURL: previewURL, type: type, webformatURL: webformatURL)
    }
}

class GalleryImageView{
    func load(image:GalleryImageViewDetails){
    }
}
