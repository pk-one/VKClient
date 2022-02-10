//
//  RealmFriends.swift
//  VKClient
//
//  Created by Pavel Olegovich on 19.09.2021.
//

import Foundation
import RealmSwift

class RealmFriends: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var firstName: String
    @Persisted var lastName: String
    @Persisted var avatar: String
    @Persisted var city: String?
    @Persisted var online: Int
    
    convenience init(_ model: FriendsItems) {
        self.init()
        self.id = model.id
        self.firstName = model.firstName
        self.lastName = model.lastName
        self.avatar = model.avatar
        self.city = model.city?.title
        self.online = model.online
    }
}
