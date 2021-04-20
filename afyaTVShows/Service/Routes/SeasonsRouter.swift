//
//  SeasonsRouter.swift
//  afyaTVShows
//
//  Created by administrador on 19/04/21.
//

import Foundation
import Alamofire

enum SeasonRouter: APIRouter{
    
    case shows(page: Int)
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        
        case .shows:
            return .get
        default:
            return .post
        }
    }
    
    // MARK: - Path
    var path: String {
        
        let path: String
        switch self {
        case .shows(let page):
            path = "/shows?page=\(page)"
        }
        
        return path
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .shows:
            return nil
        }
    }
    
}
