//
//  Photos.swift
//  VKClient
//
//  Created by Pavel Olegovich on 07.09.2021.
//

import Foundation
import SwiftyJSON

class Photos {
    let id: Int
    let ownerId: Int
    let url: String
    let likes: Int
    
    init(_ json: JSON) {
        self.id = json["id"].intValue
        self.ownerId = json["owner_id"].intValue
        self.url = json["sizes"][3]["url"].string ?? json["sizes"][2]["url"].stringValue
        self.likes = json["likes"]["count"].intValue
    }
}
