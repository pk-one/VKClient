//
//  RealmGroups.swift
//  VKClient
//
//  Created by Pavel Olegovich on 19.09.2021.
//

import Foundation
import RealmSwift

class RealmGroups: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var avatar: String?
    
    convenience init(_ model: Groups) {
        self.init()
        self.id = model.id
        self.name = model.name
        self.avatar = model.avatar
    }
}