//
//  News.swift
//  VKClient
//
//  Created by Pavel Olegovich on 03.08.2021.
//

import UIKit
import SwiftyJSON

class News {
    var id: Int
    var date: Date
    var textNews: String
    var imageNews: String
    var likeCount: Int
    var commentCount: Int
    var repostCount: Int
    var viewsCount: Int
    
    init(_ json: JSON) {
        let date = json["date"].doubleValue
        
        self.id = json["source_id"].intValue
        self.date = Date(timeIntervalSince1970: date)
        self.textNews = json["text"].stringValue
        self.imageNews = json["attachments"][0]["photo"]["sizes"][7]["url"].string ??               json["attachments"][0]["photo"]["sizes"][5]["url"].stringValue
        
        self.likeCount = json["likes"]["count"].intValue
        self.commentCount = json["comments"]["count"].intValue
        self.repostCount = json["reposts"]["count"].intValue
        self.viewsCount = json["views"]["count"].intValue
    }
}
