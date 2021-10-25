//
//  RealmCommentsGroups.swift
//  VKClient
//
//  Created by Pavel Olegovich on 29.09.2021.
//

import Foundation
import UIKit
import RealmSwift

class RealmCommentsGroups: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var avatar: String
    
    convenience init(_ model: GroupsComments) {
        self.init()
        self.id = model.id
        self.name = model.name
        self.avatar = model.avatar
    }
}
