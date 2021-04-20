//
//  Season.swift
//  afyaTVShows
//
//  Created by administrador on 19/04/21.
//

import Foundation
import Foundation
import SwiftyJSON

struct Season: Codable{
    var id: Int?
    var number: Int?
    var image: Image?
}


extension Season{
    public static func getDataFromJson(json: JSON) -> [Season]{

        guard let jsonData = try? json.rawData() else{
            return []
        }
        
        if let seasons = try? JSONDecoder().decode([Season].self, from: jsonData){
            return seasons
        }else{
            return []
        }
    }
}
