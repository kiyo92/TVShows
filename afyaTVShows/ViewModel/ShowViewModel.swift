//
//  ShowViewModel.swift
//  afyaTVShows
//
//  Created by administrador on 18/04/21.
//

import Foundation
import Alamofire
import SwiftyJSON
class ShowViewModel {
    
    // MARK: - Properties
    public var shows: [Show]? {
        didSet {
            self.didFinishFetch?()
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
    
    
    // MARK: - Network call
    func fetchShows(page: Int) {
        
        APIClient.sharedInstance.performRequest(route: APIRouters.showRouter(route: .shows(page: page)), completion: { json  in
            self.shows = Show.getDataFromJson(json: json)
        })
    }
    func searchShows(word: String) {
        print(word)
        APIClient.sharedInstance.performRequest(route: APIRouters.showRouter(route: .searchShows(word: word)), completion: { json  in
            var showItems:[Show] = []
            for show in ShowSearch.getDataFromJson(json: json) as [ShowSearch]{
                showItems.append(show.show ?? Show()) 
            }
            
            self.shows = showItems
        })
    }
    
}
