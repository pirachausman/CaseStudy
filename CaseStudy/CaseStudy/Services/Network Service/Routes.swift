//
//  Routes.swift
//  CaseStudy
//
//  Created by Usman Piracha on 29/06/2021.
//

import Foundation

struct Routes {
    struct API {
        static let baseURL = "https://pixabay.com/api/"
        
        static func makeURL() -> String {
            return "\(baseURL)?key=22282444-b232c64a8aba637d92e6cd7ba"
        }
    }
}
