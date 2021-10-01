//
//  NewsfeedComments.swift
//  VKClient
//
//  Created by Pavel Olegovich on 25.09.2021.
//

import Foundation
import SwiftyJSON

class NewsfeedComments {
    
    let id: Int
    let fromId: Int
    let date: Date
    let text: String?
    let postId: Int
    let ownerId: Int
    let image: String

    init(_ json: JSON) {
        let date = json["date"].doubleValue
        
        self.id = json["id"].intValue
        self.fromId = json["from_id"].intValue
        self.date = Date(timeIntervalSince1970: date)
        self.text = json["text"].string
        self.postId = json["post_id"].intValue
        self.ownerId = json["owner_id"].intValue
        self.image = json["attachments"][0]["photo"]["sizes"][7]["url"].string ??               json["attachments"][0]["photo"]["sizes"][5]["url"].stringValue
       
    }
}
