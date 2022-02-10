//
//  ParseNewsOperation.swift
//  VKClient
//
//  Created by Pavel Olegovich on 11.11.2021.
//

import Foundation
import SwiftyJSON

class ParseNewsOperation: Operation {
    
    private let completion: ([RealmNews]) -> Void
    
    init(completion: @escaping ([RealmNews]) -> Void) {
        self.completion = completion
    }
    
    override func main() {
        guard let getNewsOperation = dependencies.first as? GetNewsOperation,
              let data = getNewsOperation.data else { return }
        
        let json = JSON(data)
        let newsItems = json["response"]["items"].arrayValue
        let news = newsItems.map { News($0) }
        let realmNews = news.map { RealmNews ($0) }
        completion(realmNews)
    }
}
