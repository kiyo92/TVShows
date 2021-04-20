//
//  APIClient.swift
//  afyaTVShows
//
//  Created by administrador on 18/04/21.
//


import Alamofire
import SwiftyJSON
class APIClient {
    static let sharedInstance = APIClient()
    func performRequest(route:APIRouters, completion:@escaping (JSON) -> Void)  {
        AF.request(route.getUrl(),headers: route.getHeaders()).responseJSON { response  in
            
            debugPrint(route.getUrl())
            
            guard let status = response.response?.statusCode else{
                completion(JSON.null)
                return
            }
            if(status != 200){
                var json: JSON
                switch response.result {
                case let .success(value):
                    json = JSON(value)
                case .failure(let error):
                    print(error)
                    json = JSON.null
                }
                return
            }
            
            var jsonResponse: JSON
            
            switch response.result{
            case let .success(value):
                jsonResponse = JSON(value)
            case .failure:
                jsonResponse = JSON.null
            }
            
            completion(jsonResponse)
        }
    }
}
