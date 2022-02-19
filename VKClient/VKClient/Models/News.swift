//
//  News.swift
//  VKClient
//
//  Created by Pavel Olegovich on 03.08.2021.
//

import UIKit
import SwiftyJSON

class News {
    var post_id: Int
    var sourceId: Int
    var date: Date
    var textNews: String
    var imageNews: String
    var imageSizeHeight: Int
    var imageSizeWidth: Int
    
    var likeCount: Int
    var commentCount: Int
    var repostCount: Int
    var viewsCount: Int
    
    init(_ json: JSON) {
        let date = json["date"].doubleValue
        
        self.post_id = json["post_id"].intValue
        self.sourceId = json["source_id"].intValue
        self.date = Date(timeIntervalSince1970: date)
        self.textNews = json["text"].stringValue
        let sizesArray = json["attachments"][0]["photo"]["sizes"].arrayValue
        self.imageNews = sizesArray.last?["url"].stringValue ?? ""
        self.imageSizeHeight = sizesArray.last?["height"].int ?? 0
        self.imageSizeWidth = sizesArray.last?["width"].int ?? 0
        self.likeCount = json["likes"]["count"].intValue
        self.commentCount = json["comments"]["count"].intValue
        self.repostCount = json["reposts"]["count"].intValue
        self.viewsCount = json["views"]["count"].intValue
    }
}
