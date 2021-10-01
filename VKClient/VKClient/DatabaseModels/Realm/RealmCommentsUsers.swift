//
//  RealmUsers.swift
//  VKClient
//
//  Created by Pavel Olegovich on 29.09.2021.
//

import Foundation
import UIKit
import RealmSwift

class RealmCommentsUsers: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var fullName: String
    @Persisted var avatar: String
    
    convenience init(_ model: UsersComments) {
        self.init()
        self.id = model.id
        self.fullName = model.fullName
        self.avatar = model.avatar
    }
}
