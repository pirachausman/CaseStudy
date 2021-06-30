//
//  FetchPhotosGateway.swift
//  CaseStudy
//
//  Created by Usman Piracha on 29/06/2021.
//

import Foundation

protocol FetchPhotosGateway {
    func fetchPhotos(callback: @escaping FetchPhotosCallback)
}

class FetchPhotosAPIGateway: FetchPhotosGateway {
    
    let service: Service
    init(service: Service) {
        self.service = service
    }
    
    func fetchPhotos(callback: @escaping FetchPhotosCallback) {
        let urlString = Routes.API.makeURL()
        guard let url = URL(string: urlString) else {
            return
        }
        
        let fetchRequest = DefaultAPIRequest(url: url)
        service.cancel()
        service.get(request: fetchRequest) { [weak self] result in
            switch result {
            case .success(let data):
                print(data)
                do {
                    let photos = try self?.parseData(data: data)
                    callback(.success(photos ?? []))
                } catch (let error) {
                    callback(.failure(error))
                }
            case .failure(let error):
                print(error)
                callback(.failure(error))
            }
        }
    }
    
    private func parseData(data: Data) throws -> [Photo] {
        
        struct FetchPhotoResponse: Decodable {
            let hits: [PhotoDTO]
        }
        
        let decoder = JSONDecoder()
        do {
            let fetchPhotosRes = try decoder.decode(FetchPhotoResponse.self, from: data)
            let photos = fetchPhotosRes.hits.compactMap { photosDTO in
                return photosDTO.map()
            }
            return photos
        } catch (let error){
            print(error)
            throw APIError.parsingError
        }
    }
    
}


enum APIError: Error {
    case parsingError
    var localizedDescription: String {
        switch self {
        case .parsingError:
            return NSLocalizedString("Unable to parse the JSON data", comment: "Parse Error")
        }
    }
}
