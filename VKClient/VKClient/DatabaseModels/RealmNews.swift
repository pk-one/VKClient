//
//  RealmNews.swift
//  VKClient
//
//  Created by Pavel Olegovich on 20.09.2021.
//

import Foundation
import RealmSwift

class RealmNews: Object {
    @Persisted(primaryKey: true) var postId: Int
    @Persisted var sourceId: Int
    @Persisted var date: Date
    @Persisted var textNews: String
    @Persisted var imageNews: String
    @Persisted var imageSizeHeight: Int
    @Persisted var imageSizeWidth: Int
    @Persisted var likeCount: Int
    @Persisted var commentCount: Int
    @Persisted var repostCoubnt: Int
    @Persisted var viewsCount: Int
    
    convenience init(_ model: News) {
        self.init()
        self.postId = model.post_id
        self.sourceId = model.sourceId
        self.date = model.date
        self.textNews = model.textNews
        self.imageNews = model.imageNews
        self.imageSizeHeight = model.imageSizeHeight
        self.imageSizeWidth = model.imageSizeWidth
        self.likeCount = model.likeCount
        self.commentCount = model.likeCount
        self.repostCoubnt = model.repostCount
        self.viewsCount = model.viewsCount
    }
}
