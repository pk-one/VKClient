//
//  ParseUsersCommentsOperation.swift
//  VKClient
//
//  Created by Pavel Olegovich on 11.11.2021.
//

import Foundation
import SwiftyJSON

class ParseUsersCommentsOperation: Operation {
    
    private let completion: ([RealmCommentsUsers]) -> Void
    
    init(completion: @escaping ([RealmCommentsUsers]) -> Void) {
        self.completion = completion
    }
    
    override func main() {
        guard let getUsersComments = dependencies.first as? GetUsersCommentsOperation,
              let data = getUsersComments.data else { return }
        
        let json = JSON(data)
        let commentsUser = json["response"]["profiles"].arrayValue
        let usersComments = commentsUser.map { UsersComments($0) }
        let realmUsersComments = usersComments.map { RealmCommentsUsers($0) }
        completion(realmUsersComments)
    }
}

