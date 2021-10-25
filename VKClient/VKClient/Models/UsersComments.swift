//
//  Users.swift
//  VKClient
//
//  Created by Pavel Olegovich on 29.09.2021.
//

import Foundation
import SwiftyJSON

class UsersComments {
    let id: Int
    let firstName: String
    let lastName: String
    let avatar: String
    
    var fullName: String {
        return firstName + " " + lastName
    }
    
    init(_ json: JSON) {
        self.id = json["id"].intValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.avatar = json["photo_50"].stringValue
    }
}
