//
//  ParseGroupsCommentsOperation.swift
//  VKClient
//
//  Created by Pavel Olegovich on 11.11.2021.
//

import Foundation
import SwiftyJSON

class ParseGroupsCommentsOperation: Operation {
    
    private let completion: ([RealmCommentsGroups]) -> Void
    
    init(completion: @escaping ([RealmCommentsGroups]) -> Void) {
        self.completion = completion
    }
    
    override func main() {
        guard let getGroupsComments = dependencies.first as? GetGroupsCommentsOperation,
              let data = getGroupsComments.data else { return }
        
        let json = JSON(data)
        let commentsGroups = json["response"]["groups"].arrayValue
        let groupsComments = commentsGroups.map { GroupsComments($0) }
        let realmCommentsGroups = groupsComments.map { RealmCommentsGroups($0) }
        completion(realmCommentsGroups)
    }
}
