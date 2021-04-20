//
//  APIRouter.swift
//  afyaTVShows
//
//  Created by administrador on 18/04/21.
//

import Foundation
import Alamofire


protocol APIRouter: URLRequestConvertible {
    
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters : Parameters? { get }
    var url: URL {get}
    var headers: HTTPHeaders { get }
 
}

extension APIRouter{
    var url: URL {
        return URL(string: "\(APIConfig.baseURL)\(path)")!
    }
    
    var headers: HTTPHeaders{
        return [
            .accept("application/json"),
            .contentType("application/json")
        ]
    }
}

enum APIRouters: URLRequestConvertible{
    
    case showRouter(route: ShowsRouter)
    
    func getRoute() -> APIRouter{
        switch self {
        case .showRouter(let route):
            return route
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        return try getRoute().asURLRequest()
    }
    
    func getUrl() -> URL{
        return getRoute().url
    }
    
    func getHeaders() -> HTTPHeaders{
        return getRoute().headers
    }
}

extension APIRouter{
    func asURLRequest() throws -> URLRequest {
        let url = try APIConfig.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
    
}
