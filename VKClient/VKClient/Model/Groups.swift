//
//  Groups.swift
//  VKClient
//
//  Created by Pavel Olegovich on 02.09.2021.
//

import Foundation
import SwiftyJSON

class Groups{
    let name: String
    let avatar: String
    
    init(_ json: JSON) {
        self.name = json["name"].stringValue
        self.avatar = json["photo_50"].stringValue
    }
}
