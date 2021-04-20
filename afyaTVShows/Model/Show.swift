//
//  Show.swift
//  afyaTVShows
//
//  Created by administrador on 18/04/21.
//

/*
 *
 *Nome
 ○ Poster
 ○ Programação da série (dia e hora em que ela vai ao ar)
 ○ Gêneros
 ○ Resumo
 */
import Foundation
import SwiftyJSON

struct Show: Codable{
    var id: Int?
    var name: String?
    var schedule: Schedule?
    var genres: [String]?
    var summary: String?
    var image: Image?
}

struct Schedule: Codable {
    var time: String?
    var days: [String]?
}
struct Image: Codable {
    var medium, original: String
}

struct ShowSearch: Codable {
    var show: Show?
}

extension Show{
    public static func getDataFromJson(json: JSON) -> [Show]{

        guard let jsonData = try? json.rawData() else{
            return []
        }
        
        if let shows = try? JSONDecoder().decode([Show].self, from: jsonData){
            return shows
        }else{
            return []
        }
    }
}

extension ShowSearch{
    public static func getDataFromJson(json: JSON) -> [ShowSearch]{

        guard let jsonData = try? json.rawData() else{
            return []
        }
        
        if let shows = try? JSONDecoder().decode([ShowSearch].self, from: jsonData){
            return shows
        }else{
            return []
        }
    }
}

