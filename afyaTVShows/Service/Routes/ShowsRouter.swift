//
//  ShowsRouter.swift
//  afyaTVShows
//
//  Created by administrador on 18/04/21.
//

import Foundation
import Alamofire

enum ShowsRouter: APIRouter{
    
    case shows(page: Int)
    case searchShows(word: String)
    case showSeasons(showId: Int)
    case showEpisodes(showId: Int)
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        
        case .shows, .showSeasons, .showEpisodes, .searchShows:
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
        case .showSeasons(let showId):
            path = "/shows/\(showId)/seasons"
        case .showEpisodes(let showId):
            path = "/shows/\(showId)/episodes"
        case .searchShows(let word):
            path = "/search/shows?q=\(word)&embed=shows"
        }
        
        return path
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .shows, .showSeasons, .showEpisodes, .searchShows:
            return nil
        }
    }
    
}
