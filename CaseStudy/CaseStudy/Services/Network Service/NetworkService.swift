//
//  NetworkService.swift
//  CaseStudy
//
//  Created by Usman Piracha on 29/06/2021.
//

import Foundation

protocol Request {
    var urlRequest: URLRequest { get }
}

protocol Service {
    func get(request: Request, completion: @escaping (Result<Data, Error>) -> Void)
    func cancel()
}

/// A concrete implementation of Service class responsible for getting a Network resource
final class NetworkService: Service {
    enum ServiceError: Error {
        case noData
    }
    
    var task: URLSessionDataTask?
    
    func get(request: Request, completion: @escaping (Result<Data, Error>) -> Void) {
        task = URLSession.shared.dataTask(with: request.urlRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(ServiceError.noData))
                return
            }
            completion(.success(data))
        }
        task?.resume()
    }
    
    func cancel() {
        task?.cancel()
    }
}

class DefaultAPIRequest: Request {
    var urlRequest: URLRequest {
        return URLRequest(url: url)
    }
    let url: URL
    init(url: URL) {
        self.url = url
    }
}
