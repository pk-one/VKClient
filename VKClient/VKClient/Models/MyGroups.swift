//
//  Groups.swift
//  VKClient
//
//  Created by Pavel Olegovich on 02.09.2021.
//

import Foundation
import SwiftyJSON

class MyGroups{
    let id: Int
    let name: String?
    let avatar: String
    let activity: String?
    
    init(_ json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.avatar = json["photo_50"].stringValue
        self.activity = json["activity"].stringValue 
    }
}
