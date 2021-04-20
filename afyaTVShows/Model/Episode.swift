//
//  Episode.swift
//  afyaTVShows
//
//  Created by administrador on 19/04/21.
//

import Foundation
import SwiftyJSON

struct Episode: Codable{
    var id: Int?
    var name: String?
    var number: Int?
    var season: Int?
    var summary: String?
    var image: Image?
}


extension Episode{
    public static func getDataFromJson(json: JSON) -> [Episode]{

        guard let jsonData = try? json.rawData() else{
            return []
        }
        
        if let shows = try? JSONDecoder().decode([Episode].self, from: jsonData){
            return shows
        }else{
            return []
        }
    }
}
