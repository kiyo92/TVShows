//
//  ShowDetailViewModel.swift
//  afyaTVShows
//
//  Created by administrador on 20/04/21.
//

import Foundation
import Alamofire
import SwiftyJSON
class ShowDetailViewModel {
    
    // MARK: - Properties
    public var seasons: [Season]? {
        didSet {
            self.didFinishFetch?()
        }
    }
    
    public var episodes: [Episode]? {
        didSet {
            self.didFinishFetchEpisodes?()
        }
    }
    
    var error: Error? {
        didSet { self.showAlertClosure?() }
    }
    var isLoading: Bool = false {
        didSet { self.updateLoadingStatus?() }
    }

    // MARK: - Callbacks
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    var didFinishFetchEpisodes: (() -> ())?
    
    
    // MARK: - Network call
    func fetchSeasons(showId: Int) {
        
        APIClient.sharedInstance.performRequest(route: APIRouters.showRouter(route: .showSeasons(showId: showId)), completion: { json  in
            self.seasons = Season.getDataFromJson(json: json)
        })
    }
    
    func fetchEpisodes(showId: Int) {
        
        APIClient.sharedInstance.performRequest(route: APIRouters.showRouter(route: .showEpisodes(showId: showId)), completion: { json  in
            self.episodes = Episode.getDataFromJson(json: json)
        })
    }
    
}
