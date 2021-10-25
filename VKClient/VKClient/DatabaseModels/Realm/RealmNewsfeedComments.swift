//
//  RealmNeewfeedComments.swift
//  VKClient
//
//  Created by Pavel Olegovich on 25.09.2021.
//

import Foundation
import RealmSwift

class RealmNewsfeedComments: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var fromId: Int
    @Persisted var date: Date
    @Persisted var text: String?
    @Persisted var postId: Int
    @Persisted var ownerId: Int
    @Persisted var image: String?
    
    convenience init(_ model: NewsfeedComments) {
        self.init()
        self.id = model.id
        self.fromId = model.fromId
        self.date = model.date
        self.text = model.text
        self.postId = model.postId
        self.ownerId = model.ownerId
        self.image = model.image
    }
}
