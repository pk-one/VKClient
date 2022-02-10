//
//  ParseCommentsOperation.swift
//  VKClient
//
//  Created by Pavel Olegovich on 11.11.2021.
//

import Foundation
import SwiftyJSON

class ParseCommentsOperation: Operation {
    
    private let completion: ([RealmNewsfeedComments]) -> Void
    
    init(completion: @escaping ([RealmNewsfeedComments]) -> Void) {
        self.completion = completion
    }
    
    override func main() {
        guard let getComments = dependencies.first as? GetCommentsOperation,
              let data = getComments.data else { return }
        
        let json = JSON(data)
        let commentsItems = json["response"]["items"].arrayValue
        let comments = commentsItems.map { NewsfeedComments($0) }
        let realmComments = comments.map { RealmNewsfeedComments($0) }
        completion(realmComments)
    }
}
