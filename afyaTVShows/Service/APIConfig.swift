//
//  APIConfig.swift
//  afyaTVShows
//
//  Created by administrador on 18/04/21.
//

import Foundation
struct APIConfig {

    static let baseURL = "https://api.tvmaze.com"
    
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
