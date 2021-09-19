//
//  Friends.swift
//  VKClient
//
//  Created by Pavel Olegovich on 05.09.2021.
//

import Foundation
import SwiftyJSON

class Friends {
    let id: Int
    let firstName: String
    let lastName: String
    let online: Int
    let avatar: String
    let city: String
    var fullName: String {
        return firstName + " " + lastName
    }

    init(_ json: JSON) {
        self.id = json["id"].intValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.online = json["online"].intValue
        self.avatar = json["photo_50"].stringValue
        self.city = json["city"]["title"].stringValue
    }
}
